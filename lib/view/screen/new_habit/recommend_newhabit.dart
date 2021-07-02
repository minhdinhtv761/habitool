import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/view/screen/new_habit/widgets/recommend_item.dart';

class RecommendItems extends StatefulWidget {
  RecommendItems({this.getHabitModel});

  HabitCallback getHabitModel;
  @override
  _RecommendItemsState createState() => _RecommendItemsState();
}

class _RecommendItemsState extends State<RecommendItems> {
  List<Color> colorBoxs = [
    CustomColors.pink,
    CustomColors.blue,
    CustomColors.yellow,
    Colors.white
  ];
  List<String> names = ['Tập thể dục', 'Uống nước', 'Đọc sách', 'Viết nhật ký'];
  List<IconData> icons = [
    Icons.fitness_center,
    Icons.local_drink,
    Icons.book,
    Icons.drive_file_rename_outline
  ];

  List<HabitModel> recommendHabit =
      HabitFunctions.getRecommendHabits().toList();

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
              onTap: () {
                this.widget.getHabitModel(recommendHabit[index]);
              },
            );
          }),
    );
  }
}

class RecommendNewHabit extends StatelessWidget {
  const RecommendNewHabit({
    Key key,
    this.getRecommendHabit,
  }) : super(key: key);
  final HabitCallback getRecommendHabit;
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
        RecommendItems(getHabitModel: (habitModel) {
          this.getRecommendHabit(habitModel);
        }),
      ],
    );
  }
}
