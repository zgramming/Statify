// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';
import '../../widgets/custom_appbar.dart';

class MachineSurveyPage extends StatelessWidget {
  const MachineSurveyPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  Widget build(BuildContext context) {
    final items = [];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(title: "Machine Survey", withBackButton: true),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
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
          context.pushNamed(routeMachineSurveyForm, pathParameters: {
            "idMachine": idMachine,
            "id": "-1",
          });
        },
        label: const Text("Add Survey"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
