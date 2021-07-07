

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:habitool/model/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserProvider with ChangeNotifier {
  UserData user;

  Future<void> login(
      {email, password, Function(UserData) success, Function fail}) async {
    var _user = await logIn(email, password);
    if (_user != null) {
      user = _user;
      notifyListeners();
      success(_user);
    } else
      fail();

    notifyListeners();
  }



  File _image;

  File get image => _image;

  set image(File value) {
    _image = value;
  }

  final picker = ImagePicker();
  _imgFromCamera(Function success) async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    _image = File(pickedFile.path);
    success(_image);
    notifyListeners();
  }

  _imgFromGallery(Function success) async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    _image = File(pickedFile.path);
    //_image = File(pickedFile.path);
    success(_image);
    notifyListeners();
  }

  // Future<String> uploadImage(File image) async {
  //   firebase_storage.Reference firebaseStorageRef = firebase_storage
  //       .FirebaseStorage.instance
  //       .ref()
  //       .child(image.relativePath);
  //   firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(image);
  //   uploadTask.whenComplete(() async {
  //     String url = await uploadTask.snapshot.ref.getDownloadURL();
  //     return url;
  //   });
  // }

  void showPicker({BuildContext context, Function success}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('photo Library'),
                    onTap: () {
                      _imgFromGallery(success);
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('photo Camera'),
                    onTap: () {
                      _imgFromCamera(success);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
