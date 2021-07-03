import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/statistic_model.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData(int doing, int done, int cancel) {
    return new DonutPieChart(
      _createSampleData(doing, done, cancel),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 20));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Statistic, int>> _createSampleData(
      int doing, int done, int cancel) {
    final data = [
      new Statistic(0, doing, CustomColors.pink), //chưa hoàn thành
      new Statistic(1, done, CustomColors.blue), //đã
      new Statistic(2, cancel, CustomColors.grey), //hủy
    ];

    return [
      new charts.Series<Statistic, int>(
        id: 'Sales',
        domainFn: (Statistic statistic, _) => statistic.id,
        measureFn: (Statistic statistic, _) => statistic.value,
        colorFn: (Statistic statistic, _) =>
            charts.ColorUtil.fromDartColor(statistic.color),
        data: data,
      )
    ];
  }
}
