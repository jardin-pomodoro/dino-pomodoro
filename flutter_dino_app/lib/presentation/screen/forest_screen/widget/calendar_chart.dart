import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';

class CalendarChart extends StatelessWidget {
  const CalendarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    'SMTWTFS'[index],
                    style: const TextStyle(
                      color: Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 5,
                color: Color(0xff4af699),
                width: 18,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 13,
                color: Color(0xff4af699),
                width: 18,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 10,
                color: Color(0xff4af699),
                width: 18,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: 4,
                color: Color(0xff4af699),
                width: 18,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                color: Color(0xff4af699),
                width: 18,
                toY: 8,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 5,
            barRods: [
              BarChartRodData(
                color: Color(0xff4af699),
                width: 12,
                toY: 9,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 6,
            barRods: [
              BarChartRodData(
                color: Color(0xff4af699),
                width: 12,
                toY: 9,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
        ],
      ),
    );
  }
}