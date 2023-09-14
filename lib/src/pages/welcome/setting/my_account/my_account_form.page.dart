// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../model/model/helper/form/form_user_update_model.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
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
    final form = FormUserUpdateModel(
      username: _usernameController.text,
      name: _nameController.text,
      countryCode: _countryCodeController.text,
      sim1: _sim1Controller.text,
      sim2: _sim2Controller.text,
    );

    await notifier.update(
      widget.id,
      form,
    );
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
          _usernameController.text = value.username;
          _nameController.text = value.name;
          _countryCodeController.text = "${value.countryCode}";
          _sim1Controller.text = value.sim1 ?? "";
          _sim2Controller.text = value.sim2 ?? "";
        });
      },
    );

    final userAsync = ref.watch(userNotifier).onGetById.unwrapPrevious();
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
