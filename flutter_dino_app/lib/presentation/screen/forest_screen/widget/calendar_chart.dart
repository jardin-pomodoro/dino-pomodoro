import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../forest_screen_widget.dart';

class CalendarChart extends StatefulWidget {
  final CalendarGranularity granularity;
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 0,
        color: PomodoroTheme.accent,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 5,
            left: 20,
          ),
          child: AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                barGroups:
                    _chartGroups(widget.granularity, widget.dataByGranularity),
                borderData: FlBorderData(
                  border: const Border(
                    bottom: BorderSide(color: PomodoroTheme.accent),
                    left: BorderSide(color: PomodoroTheme.accent),
                  ),
                ),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles:
                      AxisTitles(sideTitles: _sideTitles(widget.granularity)),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                    reservedSize: 30,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      String text = '';
                      switch (value.toInt()) {
                        case 0:
                          text = '0M';
                          break;
                      }
                      if (value.toInt() ==
                          widget.dataByGranularity.reduce(max)) {
                        text = value.toInt().toString();
                      }
                      return Text(text, textScaleFactor: 0.8);
                    },
                  )),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SideTitles get _yearTitles => SideTitles(
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

          return Text(
            text,
            style: const TextStyle(
              color: PomodoroTheme.secondary,
              fontSize: 10,
            ),
          );
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

          return Text(
            text,
            style: const TextStyle(
              color: PomodoroTheme.secondary,
              fontSize: 15,
            ),
          );
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

          return Text(
            text,
            style: const TextStyle(
              color: PomodoroTheme.secondary,
              fontSize: 15,
            ),
          );
        },
      );

  SideTitles get _monthTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = '1';
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
            case 24:
              text = '24';
              break;
            case 26:
              text = '26';
              break;
            case 28:
              text = '28';
              break;
            case 30:
              text = '30';
              break;
          }

          return Text(
            text,
            style: const TextStyle(
              color: PomodoroTheme.secondary,
              fontSize: 12,
            ),
          );
        },
      );

  List<BarChartGroupData> _chartGroups(
      CalendarGranularity granularity, List<int> dataByGranularity) {
    final List fixedList =
        Iterable<int>.generate(dataByGranularity.length).toList();
    final double barChartWidth;
    if (granularity == CalendarGranularity.day ||
        granularity == CalendarGranularity.month) {
      barChartWidth = 6;
    } else if (granularity == CalendarGranularity.week ||
        granularity == CalendarGranularity.year) {
      barChartWidth = 15;
    } else {
      barChartWidth = 8;
    }
    return fixedList
        .map(
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: dataByGranularity[index].toDouble(),
                color: PomodoroTheme.secondary,
                width: barChartWidth,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  SideTitles _sideTitles(CalendarGranularity granularity) {
    switch (granularity) {
      case CalendarGranularity.day:
        return _dayTitles;
      case CalendarGranularity.week:
        return _weekTitles;
      case CalendarGranularity.month:
        return _monthTitles;
      case CalendarGranularity.year:
        return _yearTitles;
      default:
        return _dayTitles;
    }
  }
}

String granularityToString(CalendarGranularity granularity) {
  switch (granularity) {
    case CalendarGranularity.day:
      return 'jour';
    case CalendarGranularity.week:
      return 'semaine';
    case CalendarGranularity.month:
      return 'mois';
    case CalendarGranularity.year:
      return 'année';
    default:
      return 'jour';
  }
}
