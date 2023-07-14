import 'package:flutter/material.dart';

import '../../../utils/fonts.dart';
import '../../widgets/custom_appbar.dart';

class MachineModel {
  final int id;
  final String name;
  final double totalSMSSent;
  final double totalReply;
  final double totalFinished;
  final double totalChoose1;
  final double totalChoose2;
  final double totalChoose3;

  const MachineModel({
    required this.id,
    required this.name,
    required this.totalSMSSent,
    required this.totalReply,
    required this.totalFinished,
    required this.totalChoose1,
    required this.totalChoose2,
    required this.totalChoose3,
  });
}

final _machines = [
  const MachineModel(
    id: 1,
    name: 'Machine 1',
    totalSMSSent: 1,
    totalReply: 2,
    totalFinished: 3,
    totalChoose1: 0,
    totalChoose2: 0,
    totalChoose3: 0,
  ),
  const MachineModel(
    id: 2,
    name: 'Machine 2',
    totalSMSSent: 0,
    totalReply: 0,
    totalFinished: 0,
    totalChoose1: 0,
    totalChoose2: 0,
    totalChoose3: 0,
  ),
  const MachineModel(
    id: 3,
    name: 'Machine 3',
    totalSMSSent: 0,
    totalReply: 0,
    totalFinished: 0,
    totalChoose1: 0,
    totalChoose2: 0,
    totalChoose3: 0,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppbar(title: "Home"),
        Expanded(
          child: ListView.separated(
            itemCount: _machines.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = _machines[index];

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
                          "${index + 1}. ${item.name}",
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
                            Text("Total SMS Sent: ${item.totalSMSSent}"),
                            const SizedBox(height: 8.0),
                            Text("Total Reply: ${item.totalReply}"),
                            const SizedBox(height: 8.0),
                            Text("Total Finished: ${item.totalFinished}"),
                            const SizedBox(height: 8.0),
                            Text("Total Choose 1: ${item.totalChoose1}"),
                            const SizedBox(height: 8.0),
                            Text("Total Choose 2: ${item.totalChoose2}"),
                            const SizedBox(height: 8.0),
                            Text("Total Choose 3: ${item.totalChoose3}"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
