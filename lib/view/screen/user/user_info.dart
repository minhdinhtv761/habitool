import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/user/adress_dialog.dart';
import 'package:habitool/view/screen/user/change_password.dart';
import 'package:habitool/view/screen/user/email_dialog.dart';
import 'package:habitool/view/screen/user/gender_dialog.dart';
import 'package:habitool/view/screen/user/phone_dialog.dart';
import 'package:habitool/view/screen/user/widgets/user_namebox.dart';
import 'package:habitool/widgets/body_menu.dart';
import 'package:habitool/widgets/custom_card.dart';
import 'package:habitool/widgets/date_picker.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    BodyMenu username = BodyMenu(
      icon: Icons.person,
      title: 'Tên người dùng',
      content: 'username',
    );

    BodyMenu birth = BodyMenu(
        icon: Icons.calendar_today,
        title: 'Ngày sinh',
        content: '',
        press: () {
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => DatePicker(),
          );
        });
    BodyMenu gender = BodyMenu(
      icon: FontAwesomeIcons.transgender,
      title: 'Giới tính',
      content: 'Nam',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => GenderDialog(),
        );
      },
    );
    BodyMenu address = BodyMenu(
      icon: FontAwesomeIcons.mapMarkedAlt,
      title: 'Địa chỉ',
      content: 'Không',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => AdressDialog(),
        );
      },
    );

    BodyMenu phone = BodyMenu(
      icon: Icons.phone,
      title: 'Số điện thoại',
      content: '0123456789',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => PhoneDialog(),
        );
      },
    );
    BodyMenu email = BodyMenu(
      icon: FontAwesomeIcons.envelope,
      title: 'Email',
      content: 'example@gmail.com',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => EmailDialog(),
        );
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
