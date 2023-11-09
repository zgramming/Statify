import 'package:flutter/material.dart';

import '../../../../../model/model/machine/machine_config.model.dart';
import '../../../../../utils/fonts.dart';

class LDAHomeContentStatus extends StatelessWidget {
  const LDAHomeContentStatus({
    Key? key,
    required this.config,
  }) : super(key: key);

  final MachineConfigModel? config;

  @override
  Widget build(BuildContext context) {
    final totalSent = config?.count ?? 0;
    final totalTask = config?.taskCount ?? 0;
    final isWorking = (config?.start ?? "0") == "1";
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LDAHomeContentStatusItem(
              title: "Sent",
              children: [
                Text(
                  "$totalSent Sent",
                  style: bodyFont.copyWith(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            LDAHomeContentStatusItem(
              title: "Status",
              children: [
                Card(
                  color: isWorking ? Colors.blue[400] : Colors.red[400],
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      isWorking ? "Working" : "Stopped",
                      style: bodyFont.copyWith(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            LDAHomeContentStatusItem(
              title: "Task",
              children: [
                Text(
                  "$totalTask",
                  style: bodyFont.copyWith(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LDAHomeContentStatusItem extends StatelessWidget {
  const LDAHomeContentStatusItem({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: bodyFont.copyWith(
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 5.0,
            children: children,
          ),
        ],
      ),
    );
  }
}
