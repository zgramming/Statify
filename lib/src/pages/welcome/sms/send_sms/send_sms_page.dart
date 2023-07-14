import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';

class SendSMSPage extends ConsumerStatefulWidget {
  const SendSMSPage({super.key});

  @override
  createState() => _SendSMSPageState();
}

class _SendSMSPageState extends ConsumerState<SendSMSPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _controllerNumber;
  late final TextEditingController _controllerMessage;

  Future<void> sendSMS() async {
    final validate = _formKey.currentState?.validate();
    if (!validate!) {
      return;
    }

    final number = _controllerNumber.text;
    final message = _controllerMessage.text;

    await ref.read(smsNotifier.notifier).sendSMS(
          to: number,
          message: message,
        );

    _formKey.currentState?.reset();
  }

  @override
  void initState() {
    super.initState();
    _controllerNumber = TextEditingController();
    _controllerMessage = TextEditingController();
  }

  @override
  void dispose() {
    _controllerNumber.dispose();
    _controllerMessage.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(smsNotifier.select((value) => value.onSendSMS),
        (previous, next) {
      next.when(
        data: (value) {
          showSnackbar(
            context: context,
            message: "$value",
            backgroundColor: Colors.green,
          );
        },
        error: (error, stackTrace) {
          showSnackbar(
              context: context,
              message: error.toString(),
              backgroundColor: Colors.red);
        },
        loading: () {
          showSnackbar(context: context, message: "Loading...");
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Send SMS"),
        actions: [
          IconButton(
            onPressed: sendSMS,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controllerNumber,
                keyboardType: TextInputType.phone,
                decoration: inputDecorationRounded().copyWith(
                  labelText: "Nomor Tujuan",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor tujuan tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerMessage,
                minLines: 3,
                maxLines: 3,
                decoration: inputDecorationRounded().copyWith(
                  labelText: "Isi Pesan",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Isi pesan tidak boleh kosong";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
