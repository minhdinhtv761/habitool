import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserData {
  String uid;
  String email;
  String password;
  String displayName;
  DateTime dateOfBirth;
  String gender;
  String address;
  String phoneNumber;
  String urlAvt;
  get getUid => this.uid;

  set setUid(uid) => this.uid = uid;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getDisplayName => this.displayName;

  set setDisplayName(displayName) => this.displayName = displayName;

  get getDateOfBirth => this.dateOfBirth;

  set setDateOfBirth(dateOfBirth) => this.dateOfBirth = dateOfBirth;

  get getGender => this.gender;

  set setGender(gender) => this.gender = gender;

  get getAddress => this.address;

  set setAddress(address) => this.address = address;

  get getPhoneNumber => this.phoneNumber;

  set setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;

  get getUrlAvt => this.urlAvt;

  set setUrlAvt(urlAvt) => this.urlAvt = urlAvt;

  UserData(
      {this.uid,
      this.email,
      this.displayName,
      this.dateOfBirth,
      this.gender,
      this.address,
      this.phoneNumber,
      this.urlAvt});
  UserData.fromJson(Map<String, dynamic> data) {
    uid = data["uid"];
    email = data["email"].toString();
    password = data["password"].toString();
    displayName = data["name"].toString();
    dateOfBirth = data["DOB"].toDate();
    gender = data["gender"].toString();
    address = data["address"].toString();
    phoneNumber = data["phone"].toString();
    urlAvt = data["avatar"].toString();
  }
}
