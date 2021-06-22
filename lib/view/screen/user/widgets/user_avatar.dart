import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:habitool/services/storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatar extends StatefulWidget {
  //const UserAvatar({Key key, this.imagePath}) : super(key: key);

  //final String imagePath;

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  SecureStorage secureStorage = SecureStorage();

  UserData user;

  final _key = GlobalKey<ScaffoldState>();

  String image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    image = user.urlAvt;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  getImageSuccess(File img) async {
    if (img != null) {
      setState(() {
        image = img.path;
      });
      // firebase_storage.Reference firebaseStorageRef;
      // firebaseStorageRef =
      //     firebase_storage.FirebaseStorage.instance.ref().child(img.path);
      // firebase_storage.UploadTask uploadTask;
      // uploadTask = firebaseStorageRef.putFile(img);
      // uploadTask.whenComplete(() async {
      //   String url = await uploadTask.snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser.uid)
          .update({"avatar": img.path});
      Provider.of<UserProvider>(context, listen: false).user.urlAvt = img.path;
      // });
    }
  }

  Future<void> updateAvatar(
      {@required String avatar,
      @required uid,
      Function success,
      Function(String) fail}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({"avatar": avatar}).then((value) {
        print("Thay đổi avatar thành công");
        success();
      });
    } catch (e) {
      print(e);
      fail(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    double widthUnit = size.height * 0.2;
    return Center(
      child: Container(
        height: widthUnit,
        width: widthUnit,
        margin: EdgeInsets.only(top: 10, bottom: 15),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.pinkAccent),
                  shape: BoxShape.circle),
              child: ClipOval(
                child: image != null && image != ""
                    ? Image.network(
                        image,
                        fit: BoxFit.fill,
                      )
                    : Container(),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: RawMaterialButton(
                  onPressed: () {
                    _user.showPicker(
                        context: context, success: getImageSuccess);
                  },
                  fillColor: CustomColors.pink,
                  elevation: 0,
                  shape: CircleBorder(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Icon(
                    FontAwesomeIcons.pen,
                    color: Colors.white,
                    size: widthUnit * 0.1,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
