import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/model/habitrecord_model.dart';
import 'package:habitool/services/statistic_services.dart';

import 'package:provider/provider.dart';

class HabitServices extends ChangeNotifier {
  HabitServices();

  Future<void> addHabitData(HabitModel habitModel, BuildContext context) {
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
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
      'notif': habitModel.notif,
      'note': habitModel.note,
    }).then((value) {
      habitModel.habitId = value.id;
      //Adding Habit
      collectionHabit
          .collection('habits')
          .doc(value.id)
          .update({'id': value.id});

      this.createHabitRecordsFrom(
          habitModel, habitModel.startDate, habitModel.repeat);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.blue,
          content: Text('Thêm mới thành công'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      notifyListeners();
    }).catchError((error) => print("Failed to add habit: $error"));
  }

  void createHabitRecordsFrom(
      HabitModel habitModel, DateTime startDate, List<int> repeat) {
    DateTime date = startDate;
    Duration duration = Duration(days: 1);

    while (date.isBefore(habitModel.endDate.add(duration))) {
      for (int weekday in repeat) {
        if (date.weekday == weekday) {
          this.addHabitRecordData(habitModel, date, 0, 0);
          break;
        }
      }
      date = date.add(duration);
    }
  }

//Lữu trữ các dữ liệu thực hiện thói quen theo ngày
  Future<void> addHabitRecordData(
      HabitModel habitModel, DateTime date, int completed, int status) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    return collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.createHabitRecord(date, completed, status));
  }

  //danh sách các thói quen đang thực hiện (ngày bắt đầu < now < ngày kt)
  List<HabitModel> generalHabitListGoing = [];

  void getGoingHabitFromFirebase(DateTime now) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    if (generalHabitListGoing.isNotEmpty) generalHabitListGoing.clear();
    DateTime dateNow = DateTime(now.year, now.month, now.day);
    collectionHabit
        .collection('habits')
        .where('startDate', isLessThanOrEqualTo: dateNow)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
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

  void getFutureHabitFromFirebase(DateTime now) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    if (generalHabitListFuture.isNotEmpty) generalHabitListFuture.clear();
    DateTime dateNow = DateTime(now.year, now.month, now.day);
    collectionHabit
        .collection('habits')
        .where('startDate', isGreaterThan: dateNow)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        result.docs.forEach((habitData) {
          Map<String, dynamic> data = habitData.data();
          generalHabitListFuture.add(HabitModel.fromJson(data));
        });

        notifyListeners();
      }
    });
  }

  //Danh sách các thói quen đã thực hiện (ngày kết thúc <now)
  List<HabitModel> generalHabitListFinished = [];
  Future<void> getFinishedHabitFromFirebase(DateTime now) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    if (generalHabitListFinished.isNotEmpty) generalHabitListFinished.clear();
    DateTime dateNow = DateTime(now.year, now.month, now.day);
    //
    return collectionHabit
        .collection('habits')
        .where('endDate', isLessThan: dateNow)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
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

  void getTodayHabitFromFirebase(DateTime dateTime) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    if (todayHabitListDoing.isNotEmpty) todayHabitListDoing.clear();
    if (todayHabitListDone.isNotEmpty) todayHabitListDone.clear();
    if (todayHabitListCancel.isNotEmpty) todayHabitListCancel.clear();

    //lấy ds thói quen
    collectionHabit
        .collection('habits')
        .orderBy('isImportant', descending: true)
        .get()
        .then((result) {
//Kiểm tra: thói quen nào có ngày thực hiện trùng now
      if (result.docs.isNotEmpty) {
        result.docs.forEach((habitData) {
          Map<String, dynamic> data = habitData.data();
          var habitRecords = data['habitRecords'] as List<dynamic>;
          habitRecords.forEach((habitRecordData) async {
            DateTime dateRecord = habitRecordData['date'].toDate();
            if (dateRecord.isAtSameMomentAs(
                DateTime(dateTime.year, dateTime.month, dateTime.day))) {
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
        print('lấy danh sách trong ngày');
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

//Xóa thói quen

  void removeHabit(HabitModel habitModel, HabitTileType type,
      HabitStatus status, BuildContext context) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .delete()
        .then((value) {
      bool isGeneral = (type == HabitTileType.general);
      switch (status) {
        case HabitStatus.future:
          generalHabitListFuture.remove(habitModel);
          break;
        case HabitStatus.done:
          isGeneral
              ? generalHabitListFinished.remove(habitModel)
              : todayHabitListDone.remove(habitModel);
          break;
        case HabitStatus.doing:
          isGeneral
              ? generalHabitListGoing.remove(habitModel)
              : todayHabitListDoing.remove(habitModel);
          break;
        default:
          todayHabitListCancel.remove(habitModel);
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.blue,
          content: Text('Xóa thành công'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      notifyListeners();
    });
  }

//chỉnh sửa thói quen khi ngày bắt đầu ở sau ngày hiện tại
  Future<void> updateStartDateIsAfter(
      HabitModel habitModel, BuildContext context) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    return collectionHabit.collection('habits').doc(habitModel.habitId).update({
      'name': habitModel.name,
      'isImportant': habitModel.isImportant,
      'icon': habitModel.icon.codePoint,
      'goal': habitModel.goal,
      'unitGoal': habitModel.unitGoal,
      'startDate': habitModel.startDate,
      'endDate': habitModel.endDate,
      'repeat': habitModel.repeat,
      'time': habitModel.time,
      'notif': habitModel.notif,
      'note': habitModel.note,
    }).then((value) {
      //Adding Habit
      collectionHabit
          .collection('habits')
          .doc(habitModel.habitId)
          .update({'habitRecords': FieldValue.delete()});

      this.createHabitRecordsFrom(
          habitModel, habitModel.startDate, habitModel.repeat);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.blue,
          content: Text('Cập nhật thành công'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      notifyListeners();
    });
  }

//chỉnh sửa thói quen khi ngày bắt đầu ở trước ngày hiện tại
  Future<void> updateStartDateIsBefore(
      HabitModel newHabit, HabitModel oldHabit, BuildContext context) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    return collectionHabit.collection('habits').doc(newHabit.habitId).update({
      'name': newHabit.name,
      'isImportant': newHabit.isImportant,
      'icon': newHabit.icon.codePoint,
      'goal': newHabit.goal,
      'unitGoal': newHabit.unitGoal,
      'startDate': newHabit.startDate,
      'endDate': newHabit.endDate,
      'repeat': newHabit.repeat,
      'time': newHabit.time,
      'notif': newHabit.notif,
      'note': newHabit.note,
    }).then((value) {
      this.updateHabitRecordWhenEdit(oldHabit, newHabit);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.blue,
          content: Text('Cập nhật thành công'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      notifyListeners();
    });
  }

  void updateHabitRecordWhenEdit(HabitModel oldHabit, HabitModel newHabit) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    DateTime now = DateTime.now();
    //Xóa danh sách lưu trữ thói quen cũ kể từ ngày hn
    List<HabitRecord> oldHabitRecords = oldHabit.habitRecords.toList();
    oldHabitRecords.forEach((habitRecord) {
      if (habitRecord.date.isAfter(now)) {
        collectionHabit
            .collection('habits')
            .doc(newHabit.habitId)
            .update(newHabit.removeHabitRecord(habitRecord.date, 0, 0));
      }
    });
    //thêm mới lưu trữ thói quen mới theo lặp mới
    List<HabitRecord> newHabitRecords = newHabit.habitRecords.toList();
    newHabitRecords.forEach((habitRecord) {
      this.createHabitRecordsFrom(
          newHabit,
          DateTime(now.year, now.month, now.day).add(Duration(days: 1)),
          newHabit.repeat);
    });
  }

  void markAsCancelHabit(HabitModel habitModel, DateTime date, int completed,
      BuildContext context) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    StatisticServices statisticService =
        Provider.of<StatisticServices>(context, listen: false);
    //xóa trạng thái đang làm trong ngày
    collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.removeHabitRecord(date, completed, 0))
        .then((value) => collectionHabit
                .collection('habits')
                .doc(habitModel.habitId)
                .update(habitModel.createHabitRecord(date, completed, -1))
                .then((value) {
//thêm vào trạng thái đã hủy
              todayHabitListDoing.remove(habitModel);
              todayHabitListCancel.add(habitModel);
              notifyListeners();
              if (statisticService.doingToday > 0)
                statisticService.doingToday--;
              statisticService.cancelHabits++;
            }));
  }

  void markAsDone(HabitModel habitModel, DateTime date, int completed,
      BuildContext context) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    StatisticServices statisticService =
        Provider.of<StatisticServices>(context, listen: false);
    //xóa trạng thái đang làm trong ngày
    collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.removeHabitRecord(date, completed, 0));
    collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.createHabitRecord(date, habitModel.goal, 1));
//thêm vào trạng thái hoàn thành
    todayHabitListDoing.remove(habitModel);
    todayHabitListDone
        .add(habitModel.fromHabitRecords(date, habitModel.goal, 1));

    notifyListeners();

    if (statisticService.doingToday > 0) statisticService.doingToday--;
    statisticService.doneToday++;
  }

  void markResetHabit(HabitModel habitModel, DateTime date) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    //xóa trạng thái hoàn thành trong ngày
    collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.removeHabitRecord(date, habitModel.goal, 1))
        .then((value) => collectionHabit
                .collection('habits')
                .doc(habitModel.habitId)
                .update(habitModel.createHabitRecord(date, 0, 0))
                .then((value) {
//thêm vào trạng thái đang làm
              todayHabitListDone.remove(habitModel);
              todayHabitListDoing.add(habitModel.fromHabitRecords(date, 0, 0));

              notifyListeners();
            }));
  }

  void markRefreshHabit(HabitModel habitModel, DateTime date, int completed) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    //xóa trạng hủy trong ngày
    collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.removeHabitRecord(date, completed, -1))
        .then((value) => collectionHabit
                .collection('habits')
                .doc(habitModel.habitId)
                .update(habitModel.createHabitRecord(date, completed, 0))
                .then((value) {
//thêm vào trạng thái đang làm
              todayHabitListCancel.remove(habitModel);
              todayHabitListDoing
                  .add(habitModel.fromHabitRecords(date, completed, 0));

              notifyListeners();
            }));
  }

  void updateProgress(
      HabitModel habitModel, DateTime date, int completed, int newCompleted) {
    //
    final firestoreInstance = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser;
    var collectionHabit = firestoreInstance.collection('users').doc(auth.uid);
    //
    //xóa tiến trình đang làm trong ngày
    collectionHabit
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.removeHabitRecord(date, completed, 0));

    collectionHabit //cập nhật tiến trình
        .collection('habits')
        .doc(habitModel.habitId)
        .update(habitModel.createHabitRecord(date, newCompleted, 0));

    todayHabitListDoing.remove(habitModel);
    todayHabitListDoing.add(habitModel.fromHabitRecords(date, newCompleted, 0));

    notifyListeners();
  }
}
