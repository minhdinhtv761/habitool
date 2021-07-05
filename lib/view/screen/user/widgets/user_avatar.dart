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
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserAvatar extends StatefulWidget {
  //const UserAvatar({Key key, this.imagePath}) : super(key: key);

  //final String imagePath;

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  SecureStorage secureStorage = SecureStorage();
  String imageUrl;
  UserData user;
  //
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      user = UserData.fromJson(value.data());
      imageUrl = user.urlAvt;
      setState(() {});
    });
  }

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
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.pinkAccent),
                  shape: BoxShape.circle),
              child: ClipOval(
                child: imageUrl != null && imageUrl != ""
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      )
                    : Container(),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: RawMaterialButton(
                  onPressed: () => uploadImage(context),
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

  uploadImage(BuildContext context) async {
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      //get file name
      final fileName = basename(file.path);
      //
      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child('folderName/$fileName')
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();
        //
        user.urlAvt = downloadUrl;
        _user.onChangeAvatar(userData: user);
        //
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
