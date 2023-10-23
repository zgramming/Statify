import 'package:flutter/material.dart';

import '../../../../utils/fonts.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/form_row_body.dart';

class LongDistanceAccessManagerPage extends StatefulWidget {
  const LongDistanceAccessManagerPage({super.key});

  @override
  State<LongDistanceAccessManagerPage> createState() =>
      _LongDistanceAccessManagerPageState();
}

class _LongDistanceAccessManagerPageState
    extends State<LongDistanceAccessManagerPage> {
  final _formKey = GlobalKey<FormState>();

  final senderUnallowedController = TextEditingController();
  final arfcn2GLabelController = TextEditingController();
  final arfcn3GLabelController = TextEditingController();
  final arfcn4GLabelController = TextEditingController();
  final arfcn5GController = TextEditingController();
  final newPasswordController = TextEditingController();
  final boardIPController = TextEditingController();
  final powerVeryLowController = TextEditingController();
  final powerLowController = TextEditingController();
  final powerMediumController = TextEditingController();
  final powerHighController = TextEditingController();
  final powerVeryHighController = TextEditingController();

  bool isHiddenArfcn2G = false;
  bool isHiddenArfcn3G = false;
  bool isHiddenArfcn4G = false;
  bool isHiddenArfcn5G = false;

  bool isRemoveManagerPage = false;

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;

    if (!validate) {
      return;
    }
  }

  void init() {}

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    senderUnallowedController.dispose();
    arfcn2GLabelController.dispose();
    arfcn3GLabelController.dispose();
    arfcn4GLabelController.dispose();
    arfcn5GController.dispose();
    newPasswordController.dispose();
    boardIPController.dispose();
    powerVeryLowController.dispose();
    powerLowController.dispose();
    powerMediumController.dispose();
    powerHighController.dispose();
    powerVeryHighController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormBodyRow(
              title: "Client Allowed",
              child: TextFormField(
                controller: senderUnallowedController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Client Allowed",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FormBodyRow(
              titleWidget: _ArfcnTitle(
                title: "2G Arfcn",
                value: isHiddenArfcn2G,
                onChanged: (val) => setState(
                  () => isHiddenArfcn2G = val ?? false,
                ),
              ),
              child: TextFormField(
                controller: arfcn2GLabelController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "2G Arfcn Label",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FormBodyRow(
              titleWidget: _ArfcnTitle(
                title: "3G Arfcn",
                value: isHiddenArfcn3G,
                onChanged: (val) => setState(
                  () => isHiddenArfcn3G = val ?? false,
                ),
              ),
              child: TextFormField(
                controller: arfcn3GLabelController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "3G Arfcn Label",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FormBodyRow(
              titleWidget: _ArfcnTitle(
                title: "4G Arfcn",
                value: isHiddenArfcn4G,
                onChanged: (val) => setState(
                  () => isHiddenArfcn4G = val ?? false,
                ),
              ),
              child: TextFormField(
                controller: arfcn4GLabelController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "4G Arfcn Label",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FormBodyRow(
              titleWidget: _ArfcnTitle(
                title: "5G Arfcn",
                value: isHiddenArfcn5G,
                onChanged: (val) => setState(
                  () => isHiddenArfcn5G = val ?? false,
                ),
              ),
              child: TextFormField(
                controller: arfcn5GController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "5G Arfcn Label",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FormBodyRow(
              title: "Remove Manager Page",
              child: Align(
                alignment: Alignment.centerLeft,
                child: Checkbox(
                  value: isRemoveManagerPage,
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() => isRemoveManagerPage = value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            FormBodyRow(
              title: "New Password",
              child: TextFormField(
                controller: newPasswordController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "New Password",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FormBodyRow(
              title: "Board IP",
              child: TextFormField(
                controller: boardIPController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Board IP",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Power",
              style: headerFontBold.copyWith(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBodyRow(
                  title: "Very Low",
                  child: TextFormField(
                    controller: powerVeryLowController,
                    style: bodyFont.copyWith(fontSize: 14.0),
                    decoration: inputDecorationRounded().copyWith(
                      hintText: "Very Low",
                      border: const OutlineInputBorder(),
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                FormBodyRow(
                  title: "Low",
                  child: TextFormField(
                    controller: powerLowController,
                    style: bodyFont.copyWith(fontSize: 14.0),
                    decoration: inputDecorationRounded().copyWith(
                      hintText: "Low",
                      border: const OutlineInputBorder(),
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                FormBodyRow(
                  title: "Medium",
                  child: TextFormField(
                    controller: powerMediumController,
                    style: bodyFont.copyWith(fontSize: 14.0),
                    decoration: inputDecorationRounded().copyWith(
                      hintText: "Medium",
                      border: const OutlineInputBorder(),
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                FormBodyRow(
                  title: "High",
                  child: TextFormField(
                    controller: powerHighController,
                    style: bodyFont.copyWith(fontSize: 14.0),
                    decoration: inputDecorationRounded().copyWith(
                      hintText: "High",
                      border: const OutlineInputBorder(),
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                FormBodyRow(
                  title: "Very High",
                  child: TextFormField(
                    controller: powerVeryHighController,
                    style: bodyFont.copyWith(fontSize: 14.0),
                    decoration: inputDecorationRounded().copyWith(
                      hintText: "Very High",
                      border: const OutlineInputBorder(),
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text("Submit"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ArfcnTitle extends StatelessWidget {
  const _ArfcnTitle({
    Key? key,
    required this.title,
    required this.value,
    // ignore: unused_element
    this.onChanged,
  }) : super(key: key);

  final String title;
  final bool value;
  final void Function(bool? val)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bodyFont.copyWith(fontSize: 14.0),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
            Text(
              "Hidden",
              style: bodyFont.copyWith(fontSize: 12.0),
            ),
          ],
        )
      ],
    );
  }
}
