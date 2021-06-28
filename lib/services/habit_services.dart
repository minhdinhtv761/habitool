import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';

class HabitServices extends ChangeNotifier {
  HabitServices();
  static final firestoreInstance = FirebaseFirestore.instance;
  static final User auth = FirebaseAuth.instance.currentUser;

  var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);

  Future<void> addHabitData(HabitModel habitModel) {
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
      print('Habit Added');
      habitModel.habitId = value.id;
      //Adding Habit
      collectionHabit
          .collection('habits')
          .doc(value.id)
          .update({'id': value.id});

      this.createHabitRecords(habitModel);

      notifyListeners();
    }).catchError((error) => print("Failed to add habit: $error"));
  }

  void createHabitRecords(HabitModel habitModel) {
    DateTime date = habitModel.startDate;
    Duration duration = Duration(days: 1);
    while (date.isBefore(habitModel.endDate.add(Duration(days: 1)))) {
      this.addHabitRecordData(habitModel, date, 0, 0);
      date = date.add(duration);
    }
  }

//Lữu trữ các dữ liệu thực hiện thói quen theo ngày
  Future<void> addHabitRecordData(
      HabitModel habitModel, DateTime date, int completed, int status) {
    return collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.createHabitRecord(date, completed, status))
        .then((value) => notifyListeners());
  }

  //danh sách các thói quen đang thực hiện (ngày bắt đầu < now < ngày kt)
  List<HabitModel> generalHabitListGoing = [];

  void getGoingHabitFromFirebase() {
    if (generalHabitListGoing.isNotEmpty) generalHabitListGoing.clear();
    print('going');
    DateTime now = DateTime.now();
    DateTime dateNow = DateTime(now.year, now.month, now.day);
    collectionHabit
        .collection('habits')
        .where('startDate', isLessThanOrEqualTo: dateNow)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        print('vào going');
        result.docs.forEach((habitData) {
          Map<String, dynamic> data = habitData.data();
          DateTime endDate = data['endDate'].toDate();
          if (endDate.add(Duration(seconds: 5)).isAfter(dateNow)) {
            generalHabitListGoing.add(HabitModel.fromJson(data));
          }
        });

        notifyListeners();
      }
    });
  }

  //danh sách các thói quen sắp thực hiện (ngày bắt đầu > now)
  List<HabitModel> generalHabitListFuture = [];

  void getFutureHabitFromFirebase() {
    if (generalHabitListFuture.isNotEmpty) generalHabitListFuture.clear();
    print('future');
    collectionHabit
        .collection('habits')
        .where('startDate', isGreaterThan: DateTime.now())
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        result.docs.forEach((habitData) {
          print('vào future');
          Map<String, dynamic> data = habitData.data();
          generalHabitListFuture.add(HabitModel.fromJson(data));
        });

        notifyListeners();
      }
    });
  }

  //Danh sách các thói quen đã thực hiện (ngày kết thúc <now)
  List<HabitModel> generalHabitListFinished = [];
  Future<void> getFinishedHabitFromFirebase() {
    print('finish');
    if (generalHabitListFinished.isNotEmpty) generalHabitListFinished.clear();
    DateTime now = DateTime.now();
    DateTime dateNow = DateTime(now.year, now.month, now.day);
    return collectionHabit
        .collection('habits')
        .where('endDate', isLessThan: dateNow)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        print('vào finish');
        result.docs.forEach((habitData) {
          Map<String, dynamic> data = habitData.data();
          generalHabitListFinished.add(HabitModel.fromJson(data));
        });

        notifyListeners();
      }
    });
  }

//danh sách thói quen trong ngày
  List<HabitModel> todayHabitListDoing = [];
  List<HabitModel> todayHabitListDone = [];
  List<HabitModel> todayHabitListCancel = [];

  void getTodayHabitFromFirebase() {
    if (todayHabitListDoing.isNotEmpty) todayHabitListDoing.clear();
    if (todayHabitListDone.isNotEmpty) todayHabitListDone.clear();
    if (todayHabitListCancel.isNotEmpty) todayHabitListCancel.clear();

    print('today');
    //lấy ds thói quen
    collectionHabit.collection('habits').get().then((result) {
//Kiểm tra: thói quen nào có ngày thực hiện trùng now
      if (result.docs.isNotEmpty) {
        DateTime now = DateTime.now();

        result.docs.forEach((habitData) {
          Map<String, dynamic> data = habitData.data();
          var habitRecords = data['habitRecords'] as List<dynamic>;
          habitRecords.forEach((habitRecordData) async {
            DateTime date = habitRecordData['date'].toDate();
            if (date.isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
              {
                getTodayHabitListStatus(data, habitRecordData);
              }
            }
          });
        });

        notifyListeners();
      }
    });
  }

  void getTodayHabitListStatus(
      Map<String, dynamic> data, dynamic habitRecordData) {
    switch (habitRecordData['status']) {
      case -1:
        todayHabitListCancel.add(HabitModel.fromJson(data));
        break;
      case 0:
        print('vào doing');
        todayHabitListDoing.add(HabitModel.fromJson(data));
        break;
      default:
        todayHabitListDone.add(HabitModel.fromJson(data));
        break;
    }
  }

  //Lấy danh sách thói quen theo thời gian
  List<HabitModel> getHabitList(HabitTileType type, HabitStatus status) {
    bool isGeneral = (type == HabitTileType.general);
    print('getHabitList in HabitServices $type $status');
    switch (status) {
      case HabitStatus.future:
        return generalHabitListFuture;
        break;
      case HabitStatus.done:
        return isGeneral ? generalHabitListFinished : todayHabitListDone;
        break;
      case HabitStatus.doing:
        return isGeneral ? generalHabitListGoing : todayHabitListDoing;
        break;
      default:
        return todayHabitListCancel;
        break;
    }
  }
}
