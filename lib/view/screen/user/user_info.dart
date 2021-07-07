import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:habitool/view/screen/user/adress_dialog.dart';
import 'package:habitool/view/screen/user/change_password.dart';
import 'package:habitool/view/screen/user/gender_dialog.dart';
import 'package:habitool/view/screen/user/phone_dialog.dart';
import 'package:habitool/view/screen/user/widgets/user_namebox.dart';
import 'package:habitool/widgets/body_menu.dart';
import 'package:habitool/widgets/custom_card.dart';
import 'package:habitool/widgets/date_picker.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController displayNameController = TextEditingController();
  UserData user;
  bool _displayNameValid = true;
  bool isLoading = false;

  DateTime _birthDay = DateTime.now();
  String phoneNumber = "";
  String address = "";
  String _gender = "";
  String name = "";
  String email = "";
  //String avatar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // user = Provider.of<UserProvider>(context, listen: false).user;
    loadData();

    //avatar = user.urlAvt;
  }

  loadData() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      user = UserData.fromJson(value.data());
      phoneNumber = user.phoneNumber;
      address = user.address;
      _gender = user.gender;
      name = user.displayName;
      email = user.email;
      _birthDay = user.dateOfBirth;

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);
    BodyMenu username = BodyMenu(
      icon: Icons.person,
      title: 'Tài khoản',
      content:  _user.user.email,
    );

    BodyMenu birth = BodyMenu(
        icon: Icons.calendar_today,
        title: 'Ngày sinh',
        content: '${_birthDay.day}/${_birthDay.month}/${_birthDay.year}',
        press: () async {
          DateTime dateEdited;
          String result = await showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => DatePicker(
              dateEdited,
              callback: (value) {
                setState(() {
                  if (value != null)
                  {_birthDay=value;
                      updateDateOfBirth(
                          date: value,
                          uid: _user.user.uid,
                          success: () {
                            setState(() {
                              _birthDay = value;
                            });
                          },
                          fail: (e) {
                            print(e);
                          });

                  }
                  //dateEdited = value != null ? dateEdited : value;
                });
              },
            ),
          );
          // if (dateEdited != null) {
          //   updateDateOfBirth(
          //       date: dateEdited,
          //       uid: _user.user.uid,
          //       success: () {
          //         setState(() {
          //           _birthDay = dateEdited;
          //         });
          //       },
          //       fail: (e) {
          //         print(e);
          //       });
          // }
        });

    BodyMenu Gender = BodyMenu(
      icon: FontAwesomeIcons.transgender,
      title: 'Giới tính',
      content: _gender,
      press: () async {
        String genderEdited;
        bool result = await showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => GenderDialog(
            _gender,
            getGender: (value) {
              genderEdited = value == null ? _gender : value;
            },
          ),
        );
        if (result != null && result) {
          updateGender(
              gender: genderEdited,
              uid: _user.user.uid,
              success: () {
                setState(() {
                  _gender = genderEdited;
                });
              },
              fail: (e) {
                print(e);
              });
        }
      },
    );
    BodyMenu Address = BodyMenu(
      icon: FontAwesomeIcons.mapMarkedAlt,
      title: 'Địa chỉ',
      content: address,
      press: () async {
        String addressEdited;
        bool result = await showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => AdressDialog(
            address: address,
            edited: (value) {
              addressEdited = value;
            },
          ),
        );
        if (result != null && result) {
          updateAddress(
              address: addressEdited,
              uid: _user.user.uid,
              success: () {
                setState(() {
                  address = addressEdited;
                });
              },
              fail: (e) {
                print(e);
              });
        }
      },
    );

    BodyMenu phone = BodyMenu(
      icon: Icons.phone,
      title: 'Số điện thoại',
      content: phoneNumber,
      press: () async {
        String phoneEdited;
        bool result = await showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => PhoneDialog(
              phone: phoneNumber,
              edited: (value) {
                phoneEdited = value;
              }),
        );
        if (result != null && result) {
          updatePhonenumber(
              phone: phoneEdited,
              uid: _user.user.uid,
              success: () {
                setState(() {
                  phoneNumber = phoneEdited;
                });
              },
              fail: (e) {
                print(e);
              });
        }
      },
    );
    BodyMenu Email = BodyMenu(
      icon: FontAwesomeIcons.envelope,
      title: 'Email',
      content: email,
      press: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text('Không thể thay đổi Email!'),
            ));
        // if (result != null && result) {
        //   updateEmail(
        //       email: emailEdited,
        //       uid: _user.user.uid,
        //       success: () {
        //         setState(() {
        //           email = emailEdited;
        //         });
        //       },
        //       fail: (e) {
        //         print(e);
        //       });
        // }
      },
    );

    // BodyMenu google = BodyMenu(
    //   icon: FontAwesomeIcons.google,
    //   title: 'Google',
    //   content: 'example@gmail.com',
    //   press: () {},
    // );
    // BodyMenu facebook = BodyMenu(
    //   icon: FontAwesomeIcons.facebook,
    //   title: 'Facebook',
    //   content: 'Không',
    //   press: () {},
    // );

    BodyMenu password = BodyMenu(
      icon: Icons.vpn_key_outlined,
      title: 'Đổi mật khẩu',
      content: '',
      press: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
        );
      },
    );

    List<BodyMenu> listPersonal = [birth, Gender, Address];
    List<BodyMenu> listContact = [phone, Email];
  //  List<BodyMenu> listSocial = [google, facebook];

    //Create list
    // List<Widget> getMenuList(List list) {
    //   List<Widget> _list = [];
    //   for (var item in list) {
    //     _list.add(item);
    //     if (list.indexOf(item) != list.length - 1)
    //       _list.add(Divider(height: 1));
    //   }
    //   // if (showEndDate) {
    //   //   list.add(Divider(height: 1));
    //   //   list.add(endDate);
    //   // }
    //   return _list;
    // }
    List<Widget> getMenuList(List<BodyMenu> list) {
      List<Widget> _list = List();
      for (var item in list) {
        _list.add(item);
        if (list.indexOf(item) != list.length - 1)
          _list.add(Divider(height: 1));
      }
      return _list;
    }

    return Container(
      padding: const EdgeInsets.only(left: 21, top: 10, right: 21),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                UserNameBox(
                  displayName: name,
                ),
                CustomCard(child: username),
                CustomCard(
                  child: Column(
                    children: getMenuList(listPersonal.toList()),
                  ),
                ),
                CustomCard(
                  child: Column(
                    children: getMenuList(listContact.toList()),
                  ),
                ),
                // CustomCard(
                //   child: Column(
                //     children: getMenuList(listSocial.toList()),
                //   ),
                // ),
                CustomCard(child: password),
              ],
            ),
    );
  }
}
