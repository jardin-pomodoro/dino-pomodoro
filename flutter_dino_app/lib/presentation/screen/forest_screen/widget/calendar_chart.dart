import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';

class CalendarChart extends StatefulWidget {
  final String granularity;
  final List<int> dataByGranularity;
  const CalendarChart({
    Key? key,
    required this.granularity,
    required this.dataByGranularity,
  }) : super(key: key);

  @override
  State<CalendarChart> createState() => _CalendarChartState();
}

class _CalendarChartState extends State<CalendarChart> {


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
          barGroups: _chartGroups(widget.granularity, widget.dataByGranularity),
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _sideTitles(widget.granularity)),
            leftTitles: AxisTitles(),
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
          ),
        ),
      ),
    );
  }

  SideTitles get _monthTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = 'Jan';
          break;
        case 1:
          text = 'Fev';
          break;
        case 2:
          text = 'Mar';
          break;
        case 3:
          text = 'Avr';
          break;
        case 4:
          text = 'Mai';
          break;
        case 5:
          text = 'Jui';
          break;
        case 6:
          text = 'Jui';
          break;
        case 7:
          text = 'Aoû';
          break;
        case 8:
          text = 'Sep';
          break;
        case 9:
          text = 'Oct';
          break;
        case 10:
          text = 'Nov';
          break;
        case 11:
          text = 'Déc';
          break;
      }

      return Text(text);
    },
  );

  SideTitles get _dayTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = '0h';
          break;
        case 2:
          text = '2';
          break;
        case 4:
          text = '4';
          break;
        case 6:
          text = '6';
          break;
        case 8:
          text = '8';
          break;
        case 10:
          text = '10';
          break;
        case 12:
          text = '12';
          break;
        case 14:
          text = '14';
          break;
        case 16:
          text = '16';
          break;
        case 18:
          text = '18';
          break;
        case 20:
          text = '20';
          break;
        case 22:
          text = '22';
          break;
      }

      return Text(text);
    },
  );

  SideTitles get _weekTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = 'Lun';
          break;
        case 1:
          text = 'Mar';
          break;
        case 2:
          text = 'Mer';
          break;
        case 3:
          text = 'Jeu';
          break;
        case 4:
          text = 'Ven';
          break;
        case 5:
          text = 'Sam';
          break;
        case 6:
          text = 'Dim';
          break;
      }

      return Text(text);
    },
  );

  List<BarChartGroupData> _chartGroups(String granularity, List<int> dataByGranularity) {
    final List fixedList = Iterable<int>.generate(dataByGranularity.length).toList();
    final double barChartWidth;
    if (granularity == "day" || granularity == "month") {
      barChartWidth = 10;
    } else if(granularity == "week" || granularity == "year") {
      barChartWidth = 20;
    } else {
      barChartWidth = 10;
    }
    return fixedList.map((index) =>
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: dataByGranularity[index].toDouble(),
              color: PomodoroTheme.white,
              width: barChartWidth,
              borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
          ],
        ),
    ).toList();
  }

  SideTitles _sideTitles(String granularity) {
    print("je passe ici");
    print(granularity);
    if(granularity == 'day') {
      return _dayTitles;
    } else if (granularity == 'week'){
      return _weekTitles;
    } else if (granularity == 'month'){
      return _monthTitles;
    }
    return _monthTitles;
  }
}
