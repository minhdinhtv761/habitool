import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/services/storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserAvatar extends StatelessWidget {
  //const UserAvatar({Key key, this.imagePath}) : super(key: key);

  //final String imagePath;

  SecureStorage secureStorage = SecureStorage();
  final _key = GlobalKey<ScaffoldState>();

  // File _image;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // getImageSuccess(File image) async {
  //   if (image != null) {
  //     firebase_storage.Reference firebaseStorageRef = firebase_storage
  //         .FirebaseStorage.instance
  //         .ref()
  //         .child(image.relativePath);
  //     firebase_storage.UploadTask uploadTask =
  //         firebaseStorageRef.putFile(image);
  //     uploadTask.whenComplete(() async {
  //       String url = await uploadTask.snapshot.ref.getDownloadURL();
  //       FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(_auth.currentUser.uid)
  //           .update({"avatar": url});
  //       Provider.of<UserProvider>(context, listen: false).userData.urlAvt = url;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
            CircleAvatar(
              radius: 100,
              // backgroundImage: AssetImage(this.widget.imagePath),
              backgroundColor: CustomColors.grey,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: RawMaterialButton(
                  onPressed: () {},
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
