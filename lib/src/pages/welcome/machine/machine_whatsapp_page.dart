// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import '../../../router.dart';
import '../../../utils/enum.dart';
import '../../../utils/functions.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/dialog_view_qrcode.dart';

class DialogUploadQRCode extends ConsumerStatefulWidget {
  const DialogUploadQRCode({
    super.key,
    required this.item,
  });

  final MachineWhatsappModel item;

  @override
  ConsumerState<DialogUploadQRCode> createState() => _DialogUploadQRCodeState();
}

class _DialogUploadQRCodeState extends ConsumerState<DialogUploadQRCode> {
  File? _pickedFile;

  Future<void> onUpload() async {
    try {
      final notifier = ref.read(machineWhatsappNotifier.notifier);
      await notifier.sendQRCode(
        number: widget.item.number,
        file: _pickedFile!,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> onPickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["jpg", "png"],
      );

      if (result == null) {
        return;
      }

      final file = result.files.first;
      final path = file.path;
      if (path == null) {
        return;
      }
      setState(() {
        _pickedFile = File(path);
      });
    } catch (e) {
      log(e.toString());
      context.pop();
      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      machineWhatsappNotifier.select((value) => value.onSendQRCode),
      (previous, next) {
        next.when(
          data: (data) {
            context.pop();
            showSnackbar(
              context: context,
              message: "Success",
              backgroundColor: Colors.green,
            );

            // Refresh data
            ref.invalidate(machineNotifier);
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
            duration: const Duration(days: 1),
          ),
        );
      },
    );
    return AlertDialog(
      title: const Text("Upload QR Code"),
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Button to upload QR Code
            OutlinedButton.icon(
              onPressed: onPickFile,
              icon: const Icon(Icons.file_upload),
              label: const Text("Pick QR Code from Gallery"),
            ),

            if (_pickedFile != null) ...[
              const SizedBox(height: 16.0),
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.file(
                  _pickedFile!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text("Error loading image"),
                    );
                  },
                ),
              )
            ],
          ]),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("Close"),
        ),
        TextButton(
          onPressed: onUpload,
          child: const Text("Upload"),
        ),
      ],
    );
  }
}

class _BottomSheetOptionQRCode extends StatelessWidget {
  const _BottomSheetOptionQRCode({
    Key? key,
    required this.onViewQRCode,
    required this.onUploadQRCode,
  }) : super(key: key);

  final void Function()? onViewQRCode;
  final void Function()? onUploadQRCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: [
          IconButton(
            onPressed: onViewQRCode,
            icon: const Icon(Icons.qr_code),
            iconSize: 32.0,
          ),
          IconButton(
            onPressed: onUploadQRCode,
            icon: const Icon(Icons.file_upload),
            iconSize: 32,
          ),
        ],
      ),
    );
  }
}

class MachineWhatsAppPage extends ConsumerStatefulWidget {
  const MachineWhatsAppPage({
    super.key,
    required this.idMachine,
  });

  final String idMachine;

  @override
  ConsumerState<MachineWhatsAppPage> createState() =>
      _MachineWhatsAppPageState();
}

class _MachineWhatsAppPageState extends ConsumerState<MachineWhatsAppPage> {
  void onViewQRCode(MachineWhatsappModel item) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => DialogViewQRCode(imageUrl: item.qrCode ?? ""),
    );
  }

  void onUploadQRCode(MachineWhatsappModel item) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => DialogUploadQRCode(item: item),
    );
  }

  void onQRCodeButtonClick(MachineWhatsappModel item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _BottomSheetOptionQRCode(
          onUploadQRCode: () => onUploadQRCode(item),
          onViewQRCode: () => onViewQRCode(item),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final whatsapps = ref.watch(getMachineWhatsApp(widget.idMachine));
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(title: "Machine WhatsApp", withBackButton: true),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(machineNotifier);
              },
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
                    subtitle: Text(item.status.valueStringReadable),
                    trailing: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      children: [
                        IconButton(
                          onPressed: () => onQRCodeButtonClick(item),
                          icon: const Icon(Icons.qr_code),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(routeMachineWhatsAppForm, pathParameters: {
            "idMachine": widget.idMachine,
            "id": "-1",
          });
        },
        label: const Text("Tambah"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
