import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/fonts.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class WhatsAppPage extends ConsumerWidget {
  const WhatsAppPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final machineWhatsApps = ref.watch(getOnlyWhatsAppMachine);
    return Column(
      children: [
        const CustomAppbar(title: 'WhatsApp'),
        Expanded(
          child: ListView.separated(
            itemCount: machineWhatsApps.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = machineWhatsApps[index];

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
                              item.number,
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
                            RowBody(
                              title: "Status",
                              content: item.status,
                            ),
                            const SizedBox(height: 8.0),
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
