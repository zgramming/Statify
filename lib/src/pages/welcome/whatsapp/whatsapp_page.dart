import 'package:flutter/material.dart';

import '../../../utils/fonts.dart';
import '../../widgets/custom_appbar.dart';

class WhatsAppModel {
  final int id;
  final String name;
  final String status;
  final double totalReceived;
  final double totalRespond;
  final double totalFinished;
  final double totalChoose1;
  final double totalChoose2;
  final double totalChoose3;
  const WhatsAppModel({
    required this.id,
    required this.name,
    required this.status,
    required this.totalReceived,
    required this.totalRespond,
    required this.totalFinished,
    required this.totalChoose1,
    required this.totalChoose2,
    required this.totalChoose3,
  });
}

final _whatsAppList = [
  const WhatsAppModel(
    id: 1,
    name: 'WhatsApp 1',
    status: 'Connected',
    totalReceived: 1,
    totalRespond: 2,
    totalFinished: 3,
    totalChoose1: 0,
    totalChoose2: 0,
    totalChoose3: 0,
  ),
  const WhatsAppModel(
    id: 2,
    name: 'WhatsApp 2',
    status: 'Connected',
    totalReceived: 0,
    totalRespond: 0,
    totalFinished: 0,
    totalChoose1: 0,
    totalChoose2: 0,
    totalChoose3: 0,
  ),
  const WhatsAppModel(
    id: 3,
    name: 'WhatsApp 3',
    status: 'Connected',
    totalReceived: 0,
    totalRespond: 0,
    totalFinished: 0,
    totalChoose1: 0,
    totalChoose2: 0,
    totalChoose3: 0,
  ),
];

class WhatsAppPage extends StatelessWidget {
  const WhatsAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppbar(title: 'WhatsApp'),
        Expanded(
          child: ListView.separated(
            itemCount: _whatsAppList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = _whatsAppList[index];

              return Card(
                margin: const EdgeInsets.only(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 8.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "WhatsApp ${index + 1}",
                              style: headerFont.copyWith(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const CircleAvatar(
                              radius: 24.0,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              item.name,
                              textAlign: TextAlign.center,
                              style: bodyFont.copyWith(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("WhatsApp Status: ${item.status}"),
                            const SizedBox(height: 8.0),
                            Text("Total Receive: ${item.totalReceived}"),
                            const SizedBox(height: 8.0),
                            Text("Total Respond: ${item.totalRespond}"),
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
