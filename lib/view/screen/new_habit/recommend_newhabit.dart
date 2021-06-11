import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/new_habit/widgets/recommend_item.dart';

class RecommendItems extends StatelessWidget {
  final List<Color> colorBoxs = [
    CustomColors.pink,
    CustomColors.blue,
    CustomColors.yellow,
    Colors.white
  ];
  final List<String> names = [
    'Tập thể dục',
    'Uống nước',
    'Đọc sách',
    'Viết nhật ký'
  ];
  final List<IconData> icons = [
    Icons.fitness_center,
    Icons.local_drink,
    Icons.book,
    Icons.drive_file_rename_outline
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height * 0.12;
    return Container(
      height: _height,
      margin: EdgeInsets.only(top: 13),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RecommendItem(
            size: size,
            height: _height,
            colorBox: colorBoxs[index],
            name: names[index],
            icon: icons[index],
          );
        },
      ),
    );
  }
}

class RecommendNewHabit extends StatelessWidget {
  const RecommendNewHabit({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gợi ý thói quen',
          style: TextStyle(
            color: CustomColors.pink,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        RecommendItems(),
      ],
    );
  }
}
