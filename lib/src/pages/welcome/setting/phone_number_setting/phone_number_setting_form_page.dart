import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/database/database.dart';
import '../../../../router.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/form_row_body.dart';

class PhoneNumberSettingFormPage extends ConsumerStatefulWidget {
  const PhoneNumberSettingFormPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PhoneNumberSettingFormPage> createState() =>
      _PhoneNumberSettingFormPageState();
}

class _PhoneNumberSettingFormPageState
    extends ConsumerState<PhoneNumberSettingFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _sim1Controller;
  late final TextEditingController _sim2Controller;

  @override
  void initState() {
    super.initState();
    _sim1Controller = TextEditingController();
    _sim2Controller = TextEditingController();
    Future.microtask(() {
      final notifier = ref.read(phoneNumberSettingNotifier.notifier);
      notifier.getFirstPhoneNumberSetting(invalidate: true);
    });
  }

  @override
  void dispose() {
    _sim1Controller.dispose();
    _sim2Controller.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;
    final sim1 = _sim1Controller.text;
    final sim2 = _sim2Controller.text;

    final notifier = ref.read(phoneNumberSettingNotifier.notifier);
    final existingSetting = ref.read(phoneNumberSettingNotifier.select(
      (value) => value.onGetFirst.valueOrNull,
    ));
    await notifier.upsertPhoneNumberSetting(PhoneNumberSettingTableCompanion(
      id: drift.Value(existingSetting?.id ?? 1),
      sim1Number: drift.Value(sim1),
      sim2Number: drift.Value(sim2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Listen onUpsert
    ref.listen(phoneNumberSettingNotifier.select((value) => value.onUpsert),
        (previous, next) {
      next.when(
        data: (data) {
          if (data == null) return;
          showSnackbar(
            context: context,
            message: "Success to save phone number setting",
            backgroundColor: Colors.green,
          );

          // Restart Application to apply new setting
          context.goNamed(routeSplash);
        },
        error: (error, stackTrace) {
          showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          );
        },
        loading: () {
          showSnackbar(
            context: context,
            message: "Loading...",
            backgroundColor: Colors.blue,
          );
        },
      );
    });

    // Listen onGetFirst
    ref.listen(phoneNumberSettingNotifier.select((value) => value.onGetFirst),
        (previous, next) {
      next.whenData((value) {
        if (value == null) return;
        _sim1Controller.text = value.sim1;
        _sim2Controller.text = value.sim2;
        setState(() {});
      });
    });

    final settingsAsync = ref.watch(phoneNumberSettingNotifier).onGetFirst;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Number Setting"),
      ),
      body: Builder(builder: (context) {
        return settingsAsync.when(
          data: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          FormBodyRow(
                            title: "SIM 1",
                            child: TextFormField(
                              controller: _sim1Controller,
                              keyboardType: TextInputType.phone,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "SIM 1 is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          FormBodyRow(
                            title: "SIM 2",
                            child: TextFormField(
                              controller: _sim2Controller,
                              keyboardType: TextInputType.phone,
                              style: bodyFont.copyWith(fontSize: 14.0),
                              decoration: inputDecorationRounded().copyWith(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "SIM 2 is required";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                error.toString(),
                style: bodyFont.copyWith(color: Colors.red),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
