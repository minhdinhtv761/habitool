import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class StatisticServices {
  StatisticServices();

  int totalHabits = 0;
  int totalCreateHabits = 0;
  int doingHabits = 0;
  int doneHabits = 0;
  int cancelHabits = 0;

  void getData() {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;

    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //xóa dữ liệu cũ (tránh vòng lặp)
    if (totalHabits > 0) totalHabits = 0;
    if (totalCreateHabits > 0) totalCreateHabits = 0;
    if (doingHabits > 0) doingHabits = 0;
    if (doneHabits > 0) doneHabits = 0;
    if (cancelHabits > 0) cancelHabits = 0;

    //lấy ds thói quen
    collectionHabit.collection('habits').get().then((result) {
      if (result.docs.isNotEmpty) {
        //lấy tổng số thói quen đã được tạo
        totalHabits = result.docs.length;
        //duyệt từng thói quen
        result.docs.forEach((habitData) {
          //lấy dữ liệu từng thói quen
          Map<String, dynamic> data = habitData.data();
          //truy cập dữ liệu đã ghi
          var habitRecords = data['habitRecords'] as List<dynamic>;
          //lấy số liệu của từng thói quen đã được tạo
          totalCreateHabits += habitRecords.length;
          //duyệt dữ liệu theo từng ngày của một thói quen
          //
          habitRecords.forEach((habitRecordData) async {
            int statusRecords = habitRecordData['status'];
            this.getStatusRecords(statusRecords);
          });
        });

//        notifyListeners();
      }
    });
  }

  void getStatusRecords(int statusRecords) {
    switch (statusRecords) {
      case -1:
        cancelHabits++;
        break;
      case 0:
        doingHabits++;
        break;
      default:
        doneHabits++;
        break;
    }
  }

  int doingToday = 0;
  int doneToday = 0;
  int cancelToday = 0;

  void getDataToday() {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;

    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //lấy ds thói quen
    if (doingToday > 0) doingToday = 0;
    if (doneToday > 0) doneToday = 0;
    if (cancelToday > 0) cancelToday = 0;
    DateTime dateTime = DateTime.now();
    collectionHabit.collection('habits').get().then((result) {
//Kiểm tra: thói quen nào có ngày thực hiện trùng hôm nay
      if (result.docs.isNotEmpty) {
        //duyệt từng thói quen trong danh sách
        result.docs.forEach((habitData) {
          //lấy dữ liệu của từng thói quen
          Map<String, dynamic> data = habitData.data();
          //lấy danh sách records
          var habitRecords = data['habitRecords'] as List<dynamic>;
          //duyệt từng records
          habitRecords.forEach((habitRecordData) async {
            //lấy ngày của thói quen
            DateTime dateRecord = habitRecordData['date'].toDate();
            //kiểm tra ngày trùng
            if (dateRecord.isAtSameMomentAs(
                DateTime(dateTime.year, dateTime.month, dateTime.day))) {
              {
                getTodayHabitListStatus(data, habitRecordData);
              }
            }
          });
        });
      }
    });
  }

  void getTodayHabitListStatus(
      Map<String, dynamic> data, dynamic habitRecordData) {
    switch (habitRecordData['status']) {
      case -1:
        cancelToday++;
        break;
      case 0:
        doingToday++;
        break;
      default:
        doneToday++;
        break;
    }
  }
}
