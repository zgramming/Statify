import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class WhatsAppPage extends ConsumerStatefulWidget {
  const WhatsAppPage({super.key});

  @override
  ConsumerState<WhatsAppPage> createState() => _WhatsAppPageState();
}

class _WhatsAppPageState extends ConsumerState<WhatsAppPage> {
  void onClickQRCode(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("QR Code"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: imageNetworkLoadingBuilder(),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
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
                      if (item.qrCode != null) ...[
                        const SizedBox(height: 16.0),
                        ElevatedButton.icon(
                          onPressed: () => onClickQRCode(item.qrCode!),
                          icon: const Icon(Icons.qr_code),
                          label: const Text("QR Code"),
                        ),
                      ]
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
