import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_model/custom_provider/custom_provider.dart';
import 'widgets/lda_home_button_action.dart';
import 'widgets/lda_home_content.dart';

class LongDistanceAccessHomePage extends ConsumerWidget {
  const LongDistanceAccessHomePage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);

  final String idMachine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final machine = ref.watch(CustomProvider.getMachineByIdProvider(idMachine));
    if (machine == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        LDAHomeContent(machine: machine),
        LDAHomeButtonAction(
          machineId: machine.id,
          machine: machine,
        )
      ],
    );
  }
}
