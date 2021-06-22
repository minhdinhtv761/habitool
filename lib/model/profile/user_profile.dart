import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserData {
  String _uid;
  String email;
  String password;
  String _displayName;
  String _dateOfBirth;
  String _gender;
  String _address;
  String _phoneNumber;
  String _urlAvt;

  UserData.fromJson(Map<String, dynamic> data) {

    _uid = data["uid"];
    email = data["email"].toString();
    password = data["password"].toString();
    _displayName = data["name"].toString();
    _dateOfBirth = data["date"].toString();
    _gender = data["gender"].toString();
    _address = data["address"].toString();
    _phoneNumber = data["phone"].toString();
    _urlAvt = data["avatar"].toString();
  }
  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get displayName => _displayName;

  set displayName(String value) {
    _displayName = value;
  }

  String get dateOfBirth => _dateOfBirth;

  set dateOfBirth(String value) {
    _dateOfBirth = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get urlAvt => _urlAvt;

  set urlAvt(String value) {
    _urlAvt = value;
  }
}
