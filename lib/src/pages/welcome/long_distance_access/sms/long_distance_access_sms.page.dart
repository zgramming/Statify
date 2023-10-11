import 'package:flutter/material.dart';

import '../../../../utils/fonts.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/form_row_body.dart';

class LongDistanceAccessSMSPage extends StatefulWidget {
  const LongDistanceAccessSMSPage({super.key});

  @override
  State<LongDistanceAccessSMSPage> createState() =>
      _LongDistanceAccessSMSPageState();
}

class _LongDistanceAccessSMSPageState extends State<LongDistanceAccessSMSPage> {
  final taskCountOption = <int>[1, 2, 3, 4, 5];
  final taskCounts = <_TaskItem>[];

  int? _selectedTaskCount;
  bool _isFlashSMS = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormBodyRow(
                      title: "Task Count",
                      child: DropdownButtonFormField<int>(
                        value: _selectedTaskCount,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedTaskCount = value;
                            taskCounts.clear();
                            taskCounts.addAll(
                              List.generate(
                                value,
                                (index) => _TaskItem(
                                  index: index,
                                ),
                              ),
                            );
                          });
                        },
                        decoration: inputDecorationRounded().copyWith(
                          hintText: "Choose task count",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        items: taskCountOption
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text("$e"),
                              ),
                            )
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return "Please select task count";
                          }
                          return null;
                        },
                      ),
                    ),
                    FormBodyRow(
                      title: "Flash SMS",
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Checkbox(
                          value: _isFlashSMS,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() => _isFlashSMS = value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...taskCounts,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: elevatedButtonStyle(),
                      child: const Text("Save"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: elevatedButtonStyle(),
                      child: const FittedBox(child: Text("Save & Reboot")),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: elevatedButtonStyle(),
                      child: const Text("Reboot"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskItem extends StatefulWidget {
  const _TaskItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<_TaskItem> {
  final senderController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    senderController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Task ${widget.index + 1}",
              style: headerFontBold.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            FormBodyRow(
              title: "Sender",
              child: TextFormField(
                controller: senderController,
                style: bodyFont.copyWith(fontSize: 14.0),
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Enter sender",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            FormBodyRow(
              title: "Message",
              child: TextFormField(
                controller: messageController,
                style: bodyFont.copyWith(fontSize: 14.0),
                minLines: 3,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: inputDecorationRounded().copyWith(
                  hintText: "Enter message",
                  border: const OutlineInputBorder(),
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
