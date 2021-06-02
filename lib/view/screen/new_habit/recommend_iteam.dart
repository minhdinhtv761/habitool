import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../custom_values/custom_colors.dart';

class RecommendIteam extends StatelessWidget {
  const RecommendIteam({
    Key key,
    @required this.size,
    @required this.height,
    this.colorBox,
    this.name,
    this.icon,
  }) : super(key: key);

  final Size size;
  final double height;
  final Color colorBox;
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.3,
      margin: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: colorBox,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            width: 1,
            color: ((colorBox == Colors.white) ? CustomColors.blue : colorBox)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / (65 / 9),
              ),
              Icon(
                icon,
                color: ((colorBox == Colors.white)
                    ? CustomColors.blue
                    : Colors.white),
              ),
              SizedBox(
                height: height / (65 / 6),
              ),
              Text(
                '$name',
                style: TextStyle(
                  fontSize: 18,
                  color: ((colorBox == Colors.white)
                      ? CustomColors.blue
                      : Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
