import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/model/habitrecord_model.dart';

class HabitServices {
  HabitServices();
  static final firestoreInstance = FirebaseFirestore.instance;
  static final User auth = FirebaseAuth.instance.currentUser;

  static var collectionHabit =
      firestoreInstance.collection('users').doc('MHk3xnVSimR7AkRrmBcivBb5Ek92');

  static Future<void> addHabitData(HabitModel habitModel) {
    return collectionHabit.collection('habits').add({
      'id': '',
      'name': habitModel.name,
      'isImportant': habitModel.isImportant,
      'icon': habitModel.icon.codePoint,
      'goal': habitModel.goal,
      'unitGoal': habitModel.unitGoal,
      'startDate': habitModel.startDate,
      'endDate': habitModel.endDate,
      'repeat': habitModel.repeat,
      'time': habitModel.time,
      'note': habitModel.note,
    }).then((value) {
      habitModel.habitId = value.id;
      //Adding Habit
      collectionHabit
          .collection('habits')
          .doc(value.id)
          .update({'id': value.id});
      HabitFunctions.createHabitRecords(habitModel);
    }).catchError((error) => print("Failed to add habit: $error"));
  }

  //danh sách các thói quen đang thực hiện (ngày bắt đầu < now < ngày kt)
  List<HabitModel> _goingHabitList = [];
  Future<void> getGoingHabitFromFirebase() async {
    print('going');
    var result = await collectionHabit
        .collection('habits')
        .where('startDate', isLessThanOrEqualTo: DateTime.now())
        .get();
    result.docs.forEach((habitData) {
      Map<String, dynamic> data = habitData.data();
      DateTime endDate = data['endDate'].toDate();
      if (endDate.isAfter(DateTime.now())) {
        print('vào going');
        _goingHabitList.add(HabitModel.fromJson(data));
      }
    });
  }

  //danh sách các thói quen sắp thực hiện (ngày bắt đầu > now)
  List<HabitModel> _futureHabitList = [];
  Future<void> getFutureHabitFromFirebase() async {
    print('future');
    var result = await collectionHabit
        .collection('habits')
        .where('startDate', isGreaterThan: DateTime.now())
        .get();
    result.docs.forEach((habitData) {
      print('vào future');
      Map<String, dynamic> data = habitData.data();
      _futureHabitList.add(HabitModel.fromJson(data));
    });
  }

  //Danh sách các thói quen đã thực hiện (ngày kết thúc <now)
  List<HabitModel> _finishedHabitList = [];
  Future<void> getFinishedHabitFromFirebase() async {
    print('finish');
    var result = await collectionHabit
        .collection('habits')
        .where('endDate', isLessThan: DateTime.now())
        .get();
    result.docs.forEach((habitData) {
      print('vào finish');
      Map<String, dynamic> data = habitData.data();
      _finishedHabitList.add(HabitModel.fromJson(data));
    });
  }

//Lữu trữ các dữ liệu thực hiện thói quen theo ngày
  static Future<void> addHabitRecordData(
      HabitModel habitModel, DateTime date, int completed) {
    return collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.createHabitRecord(date, completed));
  }

//danh sách thói quen trong ngày
  List<HabitModel> _todayHabitListDoing = [];

  List<HabitModel> _todayHabitListDone = [];

  List<HabitModel> _todayHabitListCancel = [];

  Future<void> getTodayHabitFromFirebase() async {
    print('today');
    //lấy ds thói quen
    var result = await collectionHabit.collection('habits').get();
    DateTime now = DateTime.now();
//Kiểm tra: thói quen nào có ngày thực hiện trùng now
    result.docs.forEach((habitData) {
      Map<String, dynamic> data = habitData.data();
      var habitRecords = data['habitRecords'] as List<dynamic>;
      habitRecords.forEach((habitRecordData) async {
        DateTime date = habitRecordData['date'].toDate();
        if (date.isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
          {
            var completed = habitRecordData['completed'];
            if (completed == -1)
              _todayHabitListCancel.add(HabitModel.fromJson(data));
            else if (completed == data['goal'])
              _todayHabitListDone.add(HabitModel.fromJson(data));
            else {
              _todayHabitListDoing.add(HabitModel.fromJson(data));
            }
          }
        }
      });
    });
  }

  Future<void> getTodayHabitListStatus(
      Map<String, dynamic> data, dynamic habitRecordData) async {
    var completed = habitRecordData['completed'];
    if (completed == -1)
      _todayHabitListCancel.add(HabitModel.fromJson(data));
    else if (completed == data['goal'])
      _todayHabitListDone.add(HabitModel.fromJson(data));
    else {
      _todayHabitListDoing.add(HabitModel.fromJson(data));
    }
  }

  //Lấy danh sách thói quen theo thời gian
  List<HabitModel> getHabitList(HabitTileType type, HabitStatus status) {
    print('trả dữ liệu');
    bool isGeneral = (type == HabitTileType.general);
    switch (status) {
      case HabitStatus.future:
        return _futureHabitList;
        break;
      case HabitStatus.done:
        return isGeneral ? _finishedHabitList : _todayHabitListDone;
        break;
      case HabitStatus.doing:
        print('kiểm tra đang thực hiện');
        return isGeneral ? _goingHabitList : _todayHabitListDoing;
        break;
      default:
        return _todayHabitListCancel;
        break;
    }
  }
}
