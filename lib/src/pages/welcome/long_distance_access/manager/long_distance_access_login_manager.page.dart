import 'package:flutter/material.dart';

import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';

class LoginManagerPage extends StatefulWidget {
  const LoginManagerPage({super.key});

  @override
  State<LoginManagerPage> createState() => _LoginManagerPageState();
}

class _LoginManagerPageState extends State<LoginManagerPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscureText = true;

  Future<void> onSubmit() async {
    try {
      final validate = _formKey.currentState?.validate() ?? false;
      if (!validate) return;
    } catch (e) {
      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  void init() {
    usernameController.text = "admin";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN MANAGER",
                      style: bodyFontBold.copyWith(fontSize: 20.0),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Username"),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: usernameController,
                          style: bodyFont.copyWith(fontSize: 14.0),
                          decoration: inputDecorationRounded().copyWith(
                            hintText: "Username",
                            border: const OutlineInputBorder(),
                            fillColor: Colors.transparent,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Password"),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: passwordController,
                          style: bodyFont.copyWith(fontSize: 14.0),
                          decoration: inputDecorationRounded().copyWith(
                            hintText: "Password",
                            border: const OutlineInputBorder(),
                            fillColor: Colors.transparent,
                            contentPadding: const EdgeInsets.all(8),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                            ),
                          ),
                          obscureText: isObscureText,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: onSubmit,
                      style: elevatedButtonStyle(),
                      child: const Text("Submit"),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
