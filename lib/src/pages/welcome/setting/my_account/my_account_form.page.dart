import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/form/form_user_update_model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../widgets/async_error_builder.dart';
import '../../../widgets/form_row_body.dart';

class MyAccountFormPage extends ConsumerStatefulWidget {
  const MyAccountFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  ConsumerState<MyAccountFormPage> createState() => _MyAccountFormPageState();
}

class _MyAccountFormPageState extends ConsumerState<MyAccountFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _nameController;
  late final TextEditingController _countryCodeController;
  late final TextEditingController _sim1Controller;
  late final TextEditingController _sim2Controller;

  String oldSim1 = "";
  String oldSim2 = "";

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _nameController = TextEditingController();
    _countryCodeController = TextEditingController();
    _sim1Controller = TextEditingController();
    _sim2Controller = TextEditingController();

    // Call Get By Id
    Future.microtask(() {
      ref.read(userNotifier.notifier).getById(widget.id);
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _countryCodeController.dispose();
    _sim1Controller.dispose();
    _sim2Controller.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;
    final notifier = ref.read(userNotifier.notifier);
    final machines = ref.read(machineNotifier).items;
    FormUserUpdateModel form = FormUserUpdateModel(
      username: _usernameController.text,
      name: _nameController.text,
      countryCode: _countryCodeController.text,
      sim1: _sim1Controller.text,
      sim2: _sim2Controller.text,
      machineIds: const [],
      machineSimSlot: WhatSIMHasBeenChanged.none,
    );

    try {
      // Check if sim1 or sim2 has been changed
      if (oldSim1 != form.sim1 && oldSim2 != form.sim2) {
        form = form.copyWith(
          machineSimSlot: WhatSIMHasBeenChanged.both,
          machineIds: machines.map((e) => e.id).toList(),
        );
      } else if (oldSim1 != form.sim1) {
        final machine = machines.firstWhereOrNull(
          (element) => element.number == oldSim1,
        );
        form = form.copyWith(
          machineSimSlot: WhatSIMHasBeenChanged.sim1,
          machineIds: [machine?.id ?? ""],
        );
      } else if (oldSim2 != form.sim2) {
        final machine = machines.firstWhereOrNull(
          (element) => element.number == oldSim2,
        );
        form = form.copyWith(
          machineSimSlot: WhatSIMHasBeenChanged.sim2,
          machineIds: [machine?.id ?? ""],
        );
      } else {
        form = form.copyWith(
          machineSimSlot: WhatSIMHasBeenChanged.none,
          machineIds: const [],
        );
      }

      await notifier.update(
        id: widget.id,
        form: form,
      );
    } catch (e) {
      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
// Listen to userNotifier.onUpdate
    ref.listen(
      userNotifier.select((value) => value.onUpdate),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            final (_, user) = data;

            // Set User to userNotifier.user
            ref.read(userNotifier.notifier).setUser(user);

            // Invalidate machine
            ref.invalidate(getAllMachineFutureProvider);

            showSnackbar(
              context: context,
              message: "Success update profile",
              backgroundColor: Colors.green,
            );
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

    // Listen to userNotifier.onGetById
    ref.listen(
      userNotifier.select((value) => value.onGetById),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          _usernameController.text = value.username ?? "";
          _nameController.text = value.name ?? "";
          _countryCodeController.text = value.countryCode ?? "";
          _sim1Controller.text = value.sim1 ?? "";
          _sim2Controller.text = value.sim2 ?? "";

          oldSim1 = value.sim1 ?? "";
          oldSim2 = value.sim2 ?? "";
        });
      },
    );

    final userAsync = ref.watch(userNotifier).onGetById;
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Builder(
        builder: (context) {
          return userAsync.when(
            data: (data) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Card(
                    margin: const EdgeInsets.only(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Username",
                            child: TextFormField(
                              controller: _usernameController,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Username is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Name",
                            child: TextFormField(
                              controller: _nameController,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Name is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Country Code",
                            child: TextFormField(
                              controller: _countryCodeController,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Country Code is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Sim 1",
                            child: TextFormField(
                              controller: _sim1Controller,
                              keyboardType: TextInputType.number,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Sim 1 is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          FormBodyRow(
                            title: "Sim 2",
                            child: TextFormField(
                              controller: _sim2Controller,
                              keyboardType: TextInputType.number,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Sim 2 is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: onSubmit,
                            style: elevatedButtonStyle(),
                            child: const Text("Save"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            error: (error, stackTrace) => AsyncErrorBuilder(
              error: error.toString(),
              onRetry: () {
                ref.invalidate(userNotifier);
              },
            ),
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
