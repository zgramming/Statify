import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../injection.dart';
import '../../../router.dart';
import '../../widgets/row_body.dart';

class SMSPage extends ConsumerWidget {
  const SMSPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(smsNotifier).items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBar(
          title: Text("SMS (${items.length})"),
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(routeSendSMS);
              },
              icon: const Icon(Icons.sms_outlined),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            // reverse: true,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];
              final dateFormat = DateFormat("dd/MM/yyyy hh:mm:ss");
              return Card(
                margin: const EdgeInsets.only(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.only(),
                        title: Text("${index + 1}. ${item.address}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 16.0),
                            RowBody(
                              title: "Content",
                              content: item.body,
                            ),
                            const SizedBox(height: 16.0),
                            RowBody(
                              title: "Date",
                              content: dateFormat.format(item.date),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await ref.read(smsNotifier.notifier).delete(item.id);
                        },
                        icon: const Icon(Icons.delete_outline),
                        label: const Text("Hapus"),
                      ),
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
