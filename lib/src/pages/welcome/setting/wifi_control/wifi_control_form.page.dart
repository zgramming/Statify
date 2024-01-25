import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/async_error_builder.dart';
import '../../../widgets/form_body_row.dart';

class WifiControlFormPage extends ConsumerStatefulWidget {
  const WifiControlFormPage({super.key});

  @override
  ConsumerState<WifiControlFormPage> createState() =>
      _WifiControlFormPageState();
}

class _WifiControlFormPageState extends ConsumerState<WifiControlFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  void init() {
    final notifier = ref.read(wifiControlNotifier.notifier);
    Future.microtask(() {
      notifier.getFirstWifiControl();
    });
  }

  void onSubmit() async {
    try {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) return;
      final notifier = ref.read(wifiControlNotifier.notifier);
      await notifier.upsert(_urlController.text);
    } catch (e) {
      if (!mounted) return;

      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen Upsert
    ref.listen(
      wifiControlNotifier.select((value) => value.onUpsert),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            showSnackbar(
              context: context,
              message: "Success update wifi control with url: ${data.url}",
              backgroundColor: Colors.green,
            );
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
      },
    );

    // Listen to get first wifi control
    ref.listen(
      wifiControlNotifier.select((value) => value.onGetFirstWifiControl),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          _urlController.text = value.url;
        });
      },
    );

    final wifiControlAsync = ref
        .watch(
            wifiControlNotifier.select((value) => value.onGetFirstWifiControl))
        .unwrapPrevious();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Wifi Control"),
      ),
      body: Builder(
        builder: (context) {
          return wifiControlAsync.when(
            data: (data) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              FormBodyRow(
                                title: "URL Address",
                                child: TextFormField(
                                  controller: _urlController,
                                  style: bodyFont.copyWith(fontSize: 14.0),
                                  keyboardType: TextInputType.phone,
                                  decoration: inputDecorationRounded().copyWith(
                                    border: const OutlineInputBorder(),
                                    fillColor: Colors.transparent,
                                    contentPadding: const EdgeInsets.all(8),
                                    hintText: "URL Address",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "URL Address is required";
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
                        style: elevatedButtonStyle(),
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              return AsyncErrorBuilder(
                error: error.toString(),
                onRetry: () {
                  ref.invalidate(wifiControlNotifier);
                },
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
