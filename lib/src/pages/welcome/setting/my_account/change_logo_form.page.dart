import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/functions.dart';
import '../../../widgets/async_error_builder.dart';

class ChangeLogoPage extends ConsumerStatefulWidget {
  const ChangeLogoPage({super.key});

  @override
  ConsumerState<ChangeLogoPage> createState() => ChangeLogoPageState();
}

class ChangeLogoPageState extends ConsumerState<ChangeLogoPage> {
  Uint8List? _selectedFile;

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(logoNotifier.notifier);
    Future.microtask(() {
      notifier.getFirstLogo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> onUpload() async {
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

      final pickedFile = File(path);
      final pickedFileBytes = await pickedFile.readAsBytes();

      final notifier = ref.read(logoNotifier.notifier);
      await notifier.upload(pickedFileBytes);
    } catch (e) {
      log("Error Change Logo : $e");
      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to update logo
    ref.listen(
      logoNotifier.select((value) => value.onUpload),
      (previous, next) {
        next.when(
          data: (data) {
            if (data == null) return;
            log("data logo ${data.id}");

            if (mounted) {
              showSnackbar(
                context: context,
                message: "Success Upload Logo",
                backgroundColor: Colors.green,
              );
              setState(() {
                _selectedFile = data.logo;
              });
            }
          },
          error: (error, stackTrace) => showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          ),
          loading: () => showSnackbar(
            context: context,
            message: "Uploading Logo",
            backgroundColor: Colors.blue,
          ),
        );
      },
    );

    // Listen to logoNotifier.select((value) => value.onGetFirstLogo)
    ref.listen(
      logoNotifier.select((value) => value.onGetFirstLogo),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          _selectedFile = value.logo;
          setState(() {});
        });
      },
    );

    final logoAsync = ref.watch(logoNotifier).onGetFirstLogo.unwrapPrevious();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Logo Form"),
      ),
      body: Builder(builder: (context) {
        return logoAsync.when(
          data: (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_selectedFile != null) ...[
                      Image.memory(
                        _selectedFile!,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 16.0),
                    ] else ...[
                      Image.asset(
                        kURLLogoHitech,
                        // width: 100,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                    OutlinedButton.icon(
                      onPressed: onUpload,
                      icon: const Icon(Icons.file_upload),
                      label: const Text("Pick Image from Gallery"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          error: (error, stackTrace) => AsyncErrorBuilder(
            error: error.toString(),
            onRetry: () {
              ref.invalidate(logoNotifier);
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
