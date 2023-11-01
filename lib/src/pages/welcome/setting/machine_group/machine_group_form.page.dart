import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/form/form_machine_group_create_update.model.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_notifier/get_alll_machine_group.notifier.dart';
import '../../../widgets/async_error_builder.dart';
import '../../../widgets/form_body_row.dart';

class MachineGroupFormPage extends ConsumerStatefulWidget {
  const MachineGroupFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  ConsumerState<MachineGroupFormPage> createState() =>
      _MachineGroupFormPageState();
}

class _MachineGroupFormPageState extends ConsumerState<MachineGroupFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final selectedMachines = <String>[];

  bool isEdit = false;

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }

    final userId = ref.read(userNotifier).user?.id ?? "";
    final name = nameController.text;
    final machineIds = selectedMachines;
    final form = FormMachineGroupCreateOrUpdateModel(
      userId: userId,
      name: name,
      machineIds: machineIds,
    );

    if (isEdit) {
      await ref.read(machineGroupNotifier.notifier).update(
            form.copyWith(
              machineGroupId: widget.id,
            ),
          );
    } else {
      await ref.read(machineGroupNotifier.notifier).create(form);
    }
  }

  Future<void> init() async {
    if (widget.id != "-1") {
      isEdit = true;

      // Load machine group by id
      ref
          .read(machineGroupNotifier.notifier)
          .getById(machineGroupId: widget.id);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen Create
    ref.listen(
      machineGroupNotifier.select((value) => value.onCreate),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            showSnackbar(
              context: context,
              message: "Create Success ${data.name}",
              backgroundColor: Colors.green,
            );

            // Reload machine group
            ref.invalidate(getAllMachineGroupFutureProvider);

            context.pop();
          },
          error: (error, stackTrace) => showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          ),
          loading: () => showSnackbar(
            context: context,
            message: "Loading...",
            backgroundColor: Colors.blue,
          ),
        );
      },
    );

    // Listen Update
    ref.listen(
      machineGroupNotifier.select((value) => value.onUpdate),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            showSnackbar(
              context: context,
              message: "Update Success ${data.name}",
              backgroundColor: Colors.green,
            );

            // Reload machine group
            ref.invalidate(getAllMachineGroupFutureProvider);

            context.pop();
          },
          error: (error, stackTrace) => showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          ),
          loading: () => showSnackbar(
            context: context,
            message: "Loading...",
            backgroundColor: Colors.blue,
          ),
        );
      },
    );

    // Listen Get By Id
    ref.listen(
      machineGroupNotifier.select((value) => value.onGetById),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            nameController.text = data.name;
            final machineIds = data.machines?.map((e) => e.id).toList() ?? [];
            selectedMachines.addAll(machineIds);
            setState(() {});
          },
          error: (error, stackTrace) => showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          ),
          loading: () {},
        );
      },
    );

    final machineGroupByIdAsync =
        ref.watch(machineGroupNotifier).onGetById.unwrapPrevious();
    final machines = ref.watch(machineNotifier.select((value) => value.items));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Machine Group Form"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Builder(builder: (context) {
                return machineGroupByIdAsync.when(
                  data: (data) {
                    return ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 16),
                        FormBodyRow(
                          title: "Name",
                          child: TextFormField(
                            controller: nameController,
                            style: bodyFont.copyWith(fontSize: 14.0),
                            decoration: inputDecorationRounded().copyWith(
                              hintText: "Enter name",
                              border: const OutlineInputBorder(),
                              fillColor: Colors.transparent,
                              contentPadding: const EdgeInsets.all(8),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Name is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Choose Machine",
                              style: bodyFont.copyWith(
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: machines.map(
                                (e) {
                                  final isSelected =
                                      selectedMachines.contains(e.id);
                                  return ChoiceChip(
                                    label: Text(e.name),
                                    selected: isSelected,
                                    checkmarkColor: Colors.white,
                                    showCheckmark: true,
                                    selectedColor: Colors.blue,
                                    labelStyle: bodyFont.copyWith(
                                      fontSize: 12.0,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onSelected: (value) {
                                      setState(() {
                                        if (value) {
                                          selectedMachines.add(e.id);
                                        } else {
                                          selectedMachines.remove(e.id);
                                        }
                                      });
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                  error: (error, stackTrace) => AsyncErrorBuilder(
                    error: error.toString(),
                    onRetry: () {
                      ref
                          .read(machineGroupNotifier.notifier)
                          .getById(machineGroupId: widget.id);
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: onSubmit,
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
