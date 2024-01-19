import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/fonts.dart';
import '../../../../../utils/functions.dart';
import '../../../../../utils/sizes.dart';
import '../../../../../utils/styles.dart';

class LDASettingModalSyncronize extends ConsumerStatefulWidget {
  const LDASettingModalSyncronize({
    Key? key,
    required this.machineId,
  }) : super(key: key);
  final String machineId;

  @override
  ConsumerState<LDASettingModalSyncronize> createState() =>
      _LDASettingModalSyncronizeState();
}

class _LDASettingModalSyncronizeState
    extends ConsumerState<LDASettingModalSyncronize> {
  final ipController = TextEditingController();
  final intervalController = TextEditingController();

  void onTapSelectAll() {
    showSnackbar(context: context, message: "Not implemented yet");
  }

  void onTapUpload() {
    showSnackbar(context: context, message: "Not implemented yet");
  }

  void init() async {}

  @override
  void initState() {
    super.initState();

    Future.microtask(() => init());
  }

  @override
  void dispose() {
    ipController.dispose();
    intervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final machine =
    //     ref.watch(CustomProvider.getMachineByIdProvider(widget.machineId));
    // final config = machine?.config;
    // final boardIps = config?.boardIps ?? [];
    // final operators = config?.operators ?? [];

    return AlertDialog(
      insetPadding: const EdgeInsets.all(8),
      contentPadding: const EdgeInsets.all(16),
      actionsPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: w(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "4G UPLOAD",
                style: headerFontBold.copyWith(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: h(context) / 3,
                width: w(context) * 0.8,
                child: const SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SyncItem(
                        title: "OPERATOR PLMN",
                        children: [],
                      ),
                      _SyncItem(
                        title: "2G DATA",
                        children: [],
                      ),
                      _SyncItem(
                        title: "3G DATA",
                        children: [],
                      ),
                      _SyncItem(
                        title: "4G DATA",
                        children: [],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "IP",
                        style: bodyFont.copyWith(fontSize: 12.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: ipController,
                        style: bodyFont.copyWith(fontSize: 14.0),
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "IP",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Interval",
                        style: bodyFont.copyWith(fontSize: 12.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: intervalController,
                        style: bodyFont.copyWith(fontSize: 14.0),
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "Interval",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
      actions: [
        if (!isKeyboardOpen)
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onTapSelectAll,
                  style: elevatedButtonStyle(),
                  child: const Text("Select All"),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: onTapUpload,
                  style: elevatedButtonStyle(),
                  child: const Text("Upload"),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _SyncItem extends StatelessWidget {
  const _SyncItem({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style:
                bodyFont.copyWith(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          ...children,
        ],
      ),
    );
  }
}
