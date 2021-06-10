import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key key, this.imagePath}) : super(key: key);

  final String imagePath;

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
