import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/model/habit_record.dart';

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
      print("Habit Added");
      habitModel.habitId = value.id;
      //Adding Habit
      collectionHabit
          .collection('habits')
          .doc(value.id)
          .update({'id': value.id});

      HabitFunctions.createHabitRecords(habitModel);
    }).catchError((error) => print("Failed to add habit: $error"));
  }

  static Future<void> updateHabitData(HabitModel habitModel) {
    return collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update({
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
        })
        .then((value) => print("Habit Updated"))
        .catchError((error) => print("Failed to update habit: $error"));
  }

  //danh sách các thói quen đang thực hiện (ngày bắt đầu = now)
  List<HabitModel> _goingHabitList = [];
  Future<void> getGoingHabitFromFirebase() async {
    var result = await collectionHabit
        .collection('habits')
        .where('startDate', isLessThanOrEqualTo: DateTime.now())
        .get();
    result.docs.forEach((habitData) {
      Map<String, dynamic> data = habitData.data();
      DateTime endDate = data['endDate'].toDate();
      if (endDate.isAfter(DateTime.now()))
        _goingHabitList.add(HabitModel.fromFirebase(data));
    });
  }

  //danh sách các thói quen sắp thực hiện (ngày bắt đầu > now)
  List<HabitModel> _futureHabitList = [];
  Future<void> getFutureHabitFromFirebase() async {
    var result = await collectionHabit
        .collection('habits')
        .where('startDate', isGreaterThan: DateTime.now())
        .get();
    result.docs.forEach((habitData) {
      Map<String, dynamic> data = habitData.data();
      _futureHabitList.add(HabitModel.fromFirebase(data));
    });
  }

  //Danh sách các thói quen đã thực hiện (ngày kết thúc <now)
  List<HabitModel> _finishedHabitList = [];
  Future<void> getFinishedHabitFromFirebase() async {
    var result = await collectionHabit
        .collection('habits')
        .where('endDate', isLessThan: DateTime.now())
        .get();
    result.docs.forEach((habitData) {
      Map<String, dynamic> data = habitData.data();
      _finishedHabitList.add(HabitModel.fromFirebase(data));
    });
  }

//Lấy danh sách thói quen theo thời gian
  List<HabitModel> getHabitList(HabitStatus status) {
    switch (status) {
      case HabitStatus.future:
        return _futureHabitList;
        break;
      case HabitStatus.done:
        return _finishedHabitList;
        break;
      default:
        return _goingHabitList;
        break;
    }
  }

//Lữu trữ các dữ liệu thực hiện thói quen theo ngày
  static Future<void> addHabitRecordData(
      String habitId, DateTime date, int day, int goal) {
    return collectionHabit
        .collection('habits')
        .doc(habitId)
        .collection('habitRecords')
        .add({
      'date': date,
      'day': day,
      'completed': 0,
      'goal': goal,
    }).then((value) => print('added'));
  }

  static List<List<HabitRecord>> getCancelHabitRecordList(
      HabitModel habitModel, DateTime dateTime) {
    List<List<HabitRecord>> _list = [];
    collectionHabit.collection('habits').get().then((value) {
      value.docs.forEach((element) {
        Map<String, dynamic> result = element.data();
        _list.add(getCancelHabitRecord(result['id'], dateTime));
      });
    });
    return _list;
  }

  static List<HabitRecord> getCancelHabitRecord(
      String habitId, DateTime dateTime) {
    List<HabitRecord> _list = [];
    collectionHabit
        .collection('habits')
        .doc(habitId)
        .collection('habitRecords')
        .where('date', isEqualTo: dateTime)
        .where('completed', isEqualTo: -1)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Map<String, dynamic> result = element.data();
        _list.add(HabitRecord(
            dateTime: dateTime,
            day: result['day'],
            completed: result['completed']));
      });
    });
    return _list;
  }
}
