import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';

class NotificationDialog extends StatefulWidget {
  String notification;
  final StringCallback getNotif;

  NotificationDialog(this.notification, {this.getNotif});
  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  String _notif;
  List<String> buttonList = ['Bật', 'Tắt'];
  @override
  void initState() {
    print(buttonList.indexOf(this.widget.notification));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: 'Nhắc nhở',
        content: CustomRadioButton(
          initialSelection: buttonList.indexOf(this.widget.notification),
          buttonLables: buttonList,
          buttonValues: buttonList,
          radioButtonValue: (value, index) {
            _notif = value;
          },
          horizontal: true,
          enableShape: true,
          buttonSpace: 10,
          buttonColor: Colors.white,
          selectedColor: CustomColors.pink,
          elevation: 0,
        ),
        edited: () {
          if (_notif != null)
            this.widget.getNotif(_notif);
          else
            this.widget.getNotif(this.widget.notification);
        });
  }
}
