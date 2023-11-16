import 'package:flutter/material.dart';

import '../../../../../utils/fonts.dart';
import '../../../../../utils/functions.dart';
import '../../../../../utils/sizes.dart';
import '../../../../../utils/styles.dart';

class LDASettingModalSyncronize extends StatefulWidget {
  const LDASettingModalSyncronize({super.key});

  @override
  State<LDASettingModalSyncronize> createState() =>
      _LDASettingModalSyncronizeState();
}

class _LDASettingModalSyncronizeState extends State<LDASettingModalSyncronize> {
  final ipController = TextEditingController();
  final intervalController = TextEditingController();

  void init() async {}

  void onTapSelectAll() {
    showSnackbar(context: context, message: "Not implemented yet");
  }

  void onTapUpload() {
    showSnackbar(context: context, message: "Not implemented yet");
  }

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
            SizedBox(
              height: h(context) / 3,
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text("OPERATOR PLMN", style: bodyFontBold),
                      ),
                      DataColumn(
                        label: Text("2G DATA", style: bodyFontBold),
                      ),
                      DataColumn(
                        label: Text("3G DATA", style: bodyFontBold),
                      ),
                      DataColumn(
                        label: Text("4G DATA", style: bodyFontBold),
                      ),
                    ],
                    rows: [
                      for (int i = 0; i < 10; i++)
                        DataRow(
                          cells: [
                            DataCell(Text("123", style: bodyFont)),
                            DataCell(Text("123", style: bodyFont)),
                            DataCell(Text("123", style: bodyFont)),
                            DataCell(Text("123", style: bodyFont)),
                          ],
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
