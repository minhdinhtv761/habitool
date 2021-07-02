import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';

class CardItem extends StatelessWidget {
  CardItem({
    this.primaryColor,
    this.color1,
    this.color2,
    this.color3,
    this.color4,
    this.metricCount1,
    this.metricCount2,
    this.metricType,
    this.iconPath,
  });
  Color primaryColor;
  Color color1;
  Color color2;
  Color color3;
  Color color4;
  String metricType;
  String metricCount1;
  String metricCount2;
  IconData iconPath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    int count1 = int.parse(metricCount1);
    int count2 = int.parse(metricCount2);
    return Container(
      height: height * 0.25, // 30% of screen
      width: width * 0.8, // 90% of total width of screen
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(25.0)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: height * 0.1, // 12% of screen
              width: width * 0.2, // 23% of width of screen
              decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(130),
                      topRight: Radius.circular(40))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: CircleAvatar(
                backgroundColor: color2,
                radius: width * 0.04,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: height * 0.1, // 12% of screen
              width: width * 0.1, // 23% of width of screen
              decoration: BoxDecoration(
                  color: color3,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(height * 0.05),
                      bottomRight: Radius.circular(height * 0.05))),
            ),
          ),
          Positioned(
            bottom: height * 0.05,
            right: width * 0.1,
            child: CircleAvatar(
              backgroundColor: color4,
              radius: width * 0.06,
            ),
          ),
          Positioned(
            top: height * 0.02,
            left: width * 0.05,
            child: Container(
              child: Row(
                children: [
                  Icon(
                    iconPath,
                    size: height * 0.05,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: height * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metricType,
                        style: TextStyle(
                            color: CustomColors.light,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        metricCount1 != '0'
                            ? 'Ngày $metricCount1'
                            : 'Chưa bắt đầu',
                        style:
                            TextStyle(color: CustomColors.light, fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.02,
            left: width * 0.05,
            child: Container(
              child: Row(
                children: [
                  Text(
                    metricCount2,
                    style: TextStyle(
                        color: CustomColors.light,
                        fontSize: 45,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' Ngày',
                    style: TextStyle(color: CustomColors.light, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height * 0.01, // 12% of screen
              width: width * 0.7, // 23% of width of screen
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: LinearProgressIndicator(
                    value: count1 / count2,
                    valueColor: AlwaysStoppedAnimation(CustomColors.light),
                    backgroundColor: CustomColors.light.withOpacity(0.2)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
