import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../model/model/machine/machine_model.dart';
import '../../../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import 'lda_home_background_image.dart';
import 'lda_home_content_item.dart';
import 'lda_home_content_status.dart';
import 'modal_lda_home_form.page.dart';

class LDAHomeContent extends ConsumerWidget {
  final MachineModel machine;
  const LDAHomeContent({
    super.key,
    required this.machine,
  });

  static void _onTap({
    required BuildContext context,
    required MachineModel machine,
    required int index,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => ModalLDAHomeFormPage(
        idMachine: machine.id,
        index: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskCount = int.tryParse(machine.config?.taskCount ?? "0") ?? 0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(getAllMachineFutureProvider),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(minHeight: height),
              child: Stack(
                children: [
                  SizedBox(
                    height: height * 0.25,
                    child: LDAHomeBackgroundImage(
                      logo: machine.logo,
                      start: machine.config?.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LDAHomeContentStatus(config: machine.config),
                        const SizedBox(height: 20),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: height * 0.5,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: RefreshIndicator(
                            onRefresh: () async =>
                                ref.invalidate(getAllMachineFutureProvider),
                            child: ListView(
                              padding: const EdgeInsets.only(),
                              shrinkWrap: true,
                              children: [
                                if (taskCount >= 1) ...[
                                  LDAHomeContentItem(
                                    index: 1,
                                    sender: machine.config?.sender1,
                                    sms: machine.config?.sms1,
                                    onTap: () => _onTap(
                                      context: context,
                                      machine: machine,
                                      index: 1,
                                    ),
                                  ),
                                  if (taskCount >= 2)
                                    Divider(
                                      color: Colors.grey.withOpacity(0.5),
                                      thickness: 1,
                                    ),
                                ],
                                if (taskCount >= 2) ...[
                                  LDAHomeContentItem(
                                    index: 2,
                                    sender: machine.config?.sender2,
                                    sms: machine.config?.sms2,
                                    onTap: () => _onTap(
                                      context: context,
                                      machine: machine,
                                      index: 2,
                                    ),
                                  ),
                                  if (taskCount >= 3)
                                    Divider(
                                      color: Colors.grey.withOpacity(0.5),
                                      thickness: 1,
                                    ),
                                ],
                                if (taskCount >= 3) ...[
                                  LDAHomeContentItem(
                                    index: 3,
                                    sender: machine.config?.sender3,
                                    sms: machine.config?.sms3,
                                    onTap: () => _onTap(
                                      context: context,
                                      machine: machine,
                                      index: 3,
                                    ),
                                  ),
                                  if (taskCount >= 4)
                                    Divider(
                                      color: Colors.grey.withOpacity(0.5),
                                      thickness: 1,
                                    ),
                                ],
                                if (taskCount >= 4) ...[
                                  LDAHomeContentItem(
                                    index: 4,
                                    sender: machine.config?.sender4,
                                    sms: machine.config?.sms4,
                                    onTap: () => _onTap(
                                      context: context,
                                      machine: machine,
                                      index: 4,
                                    ),
                                  ),
                                  if (taskCount >= 5)
                                    Divider(
                                      color: Colors.grey.withOpacity(0.5),
                                      thickness: 1,
                                    ),
                                ],
                                if (taskCount >= 5) ...[
                                  LDAHomeContentItem(
                                    index: 5,
                                    sender: machine.config?.sender5,
                                    sms: machine.config?.sms5,
                                    onTap: () => _onTap(
                                      context: context,
                                      machine: machine,
                                      index: 5,
                                    ),
                                  ),
                                  if (taskCount >= 6)
                                    Divider(
                                      color: Colors.grey.withOpacity(0.5),
                                      thickness: 1,
                                    ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.5),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
