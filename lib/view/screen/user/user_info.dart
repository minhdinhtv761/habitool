import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:habitool/view/screen/user/adress_dialog.dart';
import 'package:habitool/view/screen/user/change_password.dart';
import 'package:habitool/view/screen/user/email_dialog.dart';
import 'package:habitool/view/screen/user/gender_dialog.dart';
import 'package:habitool/view/screen/user/phone_dialog.dart';
import 'package:habitool/view/screen/user/widgets/user_namebox.dart';
import 'package:habitool/widgets/body_menu.dart';
import 'package:habitool/widgets/custom_card.dart';
import 'package:habitool/widgets/date_picker.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitool/widgets/habit_info.dart';
import 'package:provider/provider.dart';

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
  String phoneNumber;
  String address;
  String _gender;
  String name;
  String email;
  //String avatar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    phoneNumber = user.phoneNumber;
    address = user.address;
    _gender = user.gender;
    name = user.displayName;
    email = user.email;
    //avatar = user.urlAvt;
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);
    BodyMenu username = BodyMenu(
      icon: Icons.person,
      title: 'Tên người dùng',
      content: _name,
    );

    BodyMenu birth = BodyMenu(
        icon: Icons.calendar_today,
        title: 'Ngày sinh',
        content: '${_birthDay.day}/${_birthDay.month}/${_birthDay.year}',
        press: () async {
          //String dateEdited;
          String result = await showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => DatePicker(
              _birthDay,
              callback: (value) {
                setState(() {
                  _birthDay = value;
                });
                //dateEdited = value as String;
              },
            ),
          );
          // if (result != null) {
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
    BodyMenu gender = BodyMenu(
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
              genderEdited = value;
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
    BodyMenu address = BodyMenu(
      icon: FontAwesomeIcons.mapMarkedAlt,
      title: 'Địa chỉ',
      content: _address,
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => AdressDialog(
            edited: (value) {
              setState(() {
                _address = value;
              });
            },
          ),
        );
      },
    );

    BodyMenu phone = BodyMenu(
        icon: Icons.phone,
        title: 'Số điện thoại',
        content: _phoneNumber,
        press: () {
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => PhoneDialog(
              edited: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
            ),
          );
        });
    BodyMenu email = BodyMenu(
      icon: FontAwesomeIcons.envelope,
      title: 'Email',
      content: _email,
      press: () {
        showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => EmailDialog(
                  edited: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ));
      },
    );

    BodyMenu google = BodyMenu(
      icon: FontAwesomeIcons.google,
      title: 'Google',
      content: 'example@gmail.com',
      press: () {},
    );
    BodyMenu facebook = BodyMenu(
      icon: FontAwesomeIcons.facebook,
      title: 'Facebook',
      content: 'Không',
      press: () {},
    );

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

    List<BodyMenu> listPersonal = [birth, gender, address];
    List<BodyMenu> listContact = [phone, email];
    List<BodyMenu> listSocial = [google, facebook];

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
      child: Column(
        children: [
          UserNameBox(),
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
          CustomCard(
            child: Column(
              children: getMenuList(listSocial.toList()),
            ),
          ),
          CustomCard(child: password),
        ],
      ),
    );
  }
}
