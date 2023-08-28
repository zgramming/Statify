// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../router.dart';
import '../../widgets/custom_appbar.dart';

class MachineWhatsAppPage extends ConsumerWidget {
  const MachineWhatsAppPage({
    super.key,
    required this.idMachine,
  });

  final String idMachine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final whatsapps = ref.watch(getMachineWhatsApp(idMachine));
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(title: "Machine WhatsApp", withBackButton: true),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: whatsapps.length,
              itemBuilder: (context, index) {
                final item = whatsapps[index];
                final order = index + 1;
                return ListTile(
                  leading: Text("$order"),
                  title: Text(item.number),
                  subtitle: Text(item.status),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(routeMachineWhatsAppForm, pathParameters: {
            "idMachine": idMachine,
            "id": "-1",
          });
        },
        label: const Text("Tambah"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
