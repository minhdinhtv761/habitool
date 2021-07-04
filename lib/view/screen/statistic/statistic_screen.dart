import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/statistic/chart.dart';
import 'package:habitool/view/screen/statistic/statatic_grid.dart';

import 'package:habitool/services/statistic_services.dart';

import 'package:provider/provider.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.light,
      body: Stack(
        children: <Widget>[
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: CustomColors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: size.width * 0.075),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Thống kê",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12, left: 12),
                  child: _buildStatistic(size, context),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: StatsGrid(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatistic(Size size, BuildContext context) {
    StatisticServices statisticService =
        Provider.of<StatisticServices>(context, listen: false);
    //
    int doing = statisticService.doingHabits;
    int done = statisticService.doneHabits;
    int cancel = statisticService.cancelHabits;
    //
    return Center(
      child: Container(
        width: size.width * 0.85,
        margin: EdgeInsets.only(top: 60.0, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Text(
              'Thống kê tổng số lần thực hiện',
              style: TextStyle(
                color: CustomColors.pink,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  child: DonutPieChart.withSampleData(doing, done, cancel),
                ),
                SizedBox(width: size.width * 0.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildStatisticItem(
                        CustomColors.pink, "Đang thực hiện", doing),
                    SizedBox(height: size.width * 0.01),
                    _buildStatisticItem(
                        CustomColors.blue, "Đã hoàn thành", done),
                    SizedBox(height: size.width * 0.01),
                    _buildStatisticItem(CustomColors.grey, "Đã hủy", cancel),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(Color color, String title, int value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.squareFull,
          size: 35,
          color: color,
        ),
        SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: CustomColors.black,
              ),
            ),
            Text(value.toString(),
                style: TextStyle(
                  color: CustomColors.black,
                )),
          ],
        ),
      ],
    );
  }
}
// class DonutAutoLabelChart extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;

//   DonutAutoLabelChart(this.seriesList, {this.animate});

//   /// Creates a [PieChart] with sample data and no transition.
//   factory DonutAutoLabelChart.withSampleData() {
//     return new DonutAutoLabelChart(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return new charts.PieChart(seriesList,
//         animate: animate,
//         // Configure the width of the pie slices to 60px. The remaining space in
//         // the chart will be left as a hole in the center.
//         //
//         // [ArcLabelDecorator] will automatically position the label inside the
//         // arc if the label will fit. If the label will not fit, it will draw
//         // outside of the arc with a leader line. Labels can always display
//         // inside or outside using [LabelPosition].
//         //
//         // Text style for inside / outside can be controlled independently by
//         // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
//         //
//         // Example configuring different styles for inside/outside:
//         //       new charts.ArcLabelDecorator(
//         //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
//         //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
//         defaultRenderer: new charts.ArcRendererConfig(
//             arcWidth: 60,
//             arcRendererDecorators: [new charts.ArcLabelDecorator()]));
//   }

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<Habit, String>> _createSampleData() {
//     final data = [
//       new Habit("Hoàn thành", 75),
//       new Habit("Không hoàn thành", 25),
//       new Habit("Hủy", 5),
//     ];

//     return [
//       new charts.Series<Habit, String>(
//         id: 'Sales',
//         domainFn: (Habit habit, _) => habit.type,
//         measureFn: (Habit habit, _) => habit.number,
//         data: data,
//         // Set a label accessor to control the text of the arc label.
//         labelAccessorFn: (Habit row, _) => '${row.type}: ${row.number}',
//       )
//     ];
//   }
// }

// /// Sample linear data type.
// class Habit {
//   final String type;
//   final int number;

//   Habit(this.type, this.number);
// }