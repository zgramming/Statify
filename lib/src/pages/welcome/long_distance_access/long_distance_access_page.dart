import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../utils/fonts.dart';
import 'dart:math' as math;
import '../../widgets/custom_appbar.dart';

class StatisticMachineModel {
  final int id;
  final String machineName;
  final double totalData;
  const StatisticMachineModel({
    required this.id,
    required this.machineName,
    required this.totalData,
  });
}

final _statistics = [
  const StatisticMachineModel(
    id: 1,
    machineName: 'Statistic 1',
    totalData: 10,
  ),
  const StatisticMachineModel(
    id: 2,
    machineName: 'Statistic 2',
    totalData: 20,
  ),
  const StatisticMachineModel(
    id: 3,
    machineName: 'Statistic 3',
    totalData: 30,
  ),
  const StatisticMachineModel(
    id: 4,
    machineName: 'Statistic 4',
    totalData: 40,
  ),
  const StatisticMachineModel(
    id: 5,
    machineName: 'Statistic 5',
    totalData: 50,
  ),
];

class LongDistanceAccessPage extends StatelessWidget {
  const LongDistanceAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppbar(title: "Long Distance Access"),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  child: Card(
                    margin: EdgeInsets.only(),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: _CustomBarChart(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _statistics.length,
                  itemBuilder: (context, index) {
                    final item = _statistics[index];
                    return Card(
                      margin: const EdgeInsets.only(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 8.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${index + 1}. ${item.machineName}",
                                style: headerFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text("Total Data: ${item.totalData}"),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomBarChart extends StatelessWidget {
  const _CustomBarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: _statistics.map(
          (e) {
            final randomColor =
                Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0);
            return BarChartGroupData(
              x: e.id,
              barRods: [
                BarChartRodData(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  toY: e.totalData,
                  width: 16,
                  color: randomColor,
                ),
              ],
            );
          },
        ).toList(),
        groupsSpace: 16,
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final item = _statistics[value.toInt() - 1];
                final initial =
                    item.machineName.split(" ").map((e) => e[0]).join("");
                return Text(
                  initial,
                  style: headerFont.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
        // barTouchData: BarTouchData(
        //   enabled: true,
        //   touchTooltipData: BarTouchTooltipData(
        //     tooltipBgColor: Colors.transparent,
        //     tooltipPadding: const EdgeInsets.all(0),
        //     tooltipMargin: 8,
        //   ),
        // ),
        borderData: FlBorderData(show: false),
      ),
      swapAnimationCurve: Curves.easeInOut,
      swapAnimationDuration: const Duration(milliseconds: 500),
    );
  }
}
