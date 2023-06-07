import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../injection.dart';
import '../../widgets/row_body.dart';

class CallPage extends ConsumerWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(phoneNotifier).items;
    return ListView.separated(
      itemCount: items.length,
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      reverse: true,
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
                  title: Text("${index + 1}. ${item.number}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                    await ref.read(phoneNotifier.notifier).delete(item.id);
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Hapus"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
