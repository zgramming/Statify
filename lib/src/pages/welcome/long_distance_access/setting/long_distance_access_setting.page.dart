import 'package:flutter/material.dart';

import '../../../../utils/fonts.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/form_row_body.dart';

class LongDistanceAccessSettingPage extends StatefulWidget {
  const LongDistanceAccessSettingPage({super.key});

  @override
  State<LongDistanceAccessSettingPage> createState() =>
      _LongDistanceAccessSettingPageState();
}

class _LongDistanceAccessSettingPageState
    extends State<LongDistanceAccessSettingPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isShowPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FormBodyRow(
                            title: "Wifi Name",
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: nameController,
                                    style: bodyFont.copyWith(fontSize: 14.0),
                                    decoration:
                                        inputDecorationRounded().copyWith(
                                      hintText: "Wifi Name",
                                      border: const OutlineInputBorder(),
                                      fillColor: Colors.transparent,
                                      contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          FormBodyRow(
                            title: "Wifi Password",
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: passwordController,
                                    style: bodyFont.copyWith(fontSize: 14.0),
                                    decoration:
                                        inputDecorationRounded().copyWith(
                                      hintText: "Wifi Password",
                                      border: const OutlineInputBorder(),
                                      fillColor: Colors.transparent,
                                      contentPadding: const EdgeInsets.all(8),
                                    ),
                                    obscureText: !isShowPassword,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isShowPassword = !isShowPassword;
                                    });
                                  },
                                  child: Icon(
                                    isShowPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Wifi Hidden",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: true,
                              onChanged: (value) {},
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Flash SMS",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: true,
                              onChanged: (value) {},
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Save Sentlist",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: true,
                              onChanged: (value) {},
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Auto ARFCN",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: true,
                              onChanged: (value) {},
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Auto Reset",
                                style: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              value: true,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Network",
                            style: headerFontBold.copyWith(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CheckboxListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "GSM",
                              style: bodyFont.copyWith(fontSize: 14.0),
                            ),
                            value: true,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "WCDMA",
                              style: bodyFont.copyWith(fontSize: 14.0),
                            ),
                            value: true,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "LTE",
                              style: bodyFont.copyWith(fontSize: 14.0),
                            ),
                            value: true,
                            onChanged: (value) {},
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: elevatedButtonStyle(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                backgroundColor: Colors.blueGrey,
                              ).copyWith(),
                              icon: const Icon(Icons.sync),
                              label: const Text("Syncronize"),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
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
