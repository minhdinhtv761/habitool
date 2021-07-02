import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/view/screen/home_screen.dart';
import 'package:habitool/widgets/custom_dialog.dart';

import 'package:provider/provider.dart';

class MessageBox {
  static Widget messageDialog = CustomDialog(
    title: 'Lỗi!',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ngày bắt đầu đang bé hơn ngày hiện tại',
          style: TextStyle(
            color: CustomColors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Bạn không thể chỉnh sửa ngày bắt đầu, mục tiêu của thói quen',
          style: TextStyle(
            color: CustomColors.darkgrey,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
    edited: () {},
  );

  static Widget addedHabit(BuildContext context) {
    return CustomDialog(
      title: 'Thông báo',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thêm mới thành công',
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Bạn vừa thêm mới thành công một thói quen',
            style: TextStyle(
              color: CustomColors.darkgrey,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      edited: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      },
    );
  }

  static Widget removeHabit({Function onSubmit}) {
    return CustomDialog(
      title: 'Thông báo',
      content: Text(
        'Bạn có muốn xóa thói quen này?',
        style: TextStyle(
          color: CustomColors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      edited: onSubmit,
    );
  }

  static Widget warningSelection({Function onSubmit}) {
    return CustomDialog(
      title: 'Cảnh báo',
      content: Text(
        'Thói quen bạn chọn không phải của ngày hôm nay. Bạn có muốn tiếp tục?',
        style: TextStyle(
          color: CustomColors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      edited: onSubmit,
    );
  }

  static Widget erroInput() {
    return CustomDialog(
      title: 'Lỗi!',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sai thông tin',
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Thông tin không được bỏ trống hoặc mục tiêu cần lớn hơn 1',
            style: TextStyle(
              color: CustomColors.darkgrey,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      edited: () {},
    );
  }

  static Widget erroInputProgress() {
    return CustomDialog(
      title: 'Lỗi!',
      content: Text(
        'Tiến độ đang nhỏ hơn mục tiêu',
        style: TextStyle(
          color: CustomColors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
