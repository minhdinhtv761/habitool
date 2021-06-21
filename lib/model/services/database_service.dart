import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  final String uid;
  DatabaseService( this.uid );

  final CollectionReference collectionHabit = FirebaseFirestore.instance.collection('habit');

  Future<void> updateHabitData(String name, bool isImportant, IconData icon, int goal, String unitGoal,
       DateTime startDate, DateTime endDate, String repeat, DateTime time, String note) {
    return collectionHabit
        .add({
          'uidUser': this.uid,
          'name': name,
          'isImportant': isImportant,
          'icon': icon.toString(),
          'goal' : goal,
          'unitGoal' : unitGoal,
          'startDate' : startDate,
          'endDate' : endDate,
          'repeat' : repeat,
          'time' : '${time.hour}:${time.minute}',
          'note' : note,
    })
        .then((value) => print("Habit Added"))
        .catchError((error) => print("Failed to add habit: $error"));
  }
}