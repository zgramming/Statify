import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) return;

    final username = usernameController.text;
    final password = passwordController.text;

    log("""
      username: $username
      password: $password
""");

    context.goNamed(routeHome);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: darkPrimaryColor),
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: kGradientColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: h,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: bodyFont.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: usernameController,
                            decoration: inputDecorationRounded().copyWith(
                              hintText: "Username",
                              hintStyle: bodyFont.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(Icons.person),
                              fillColor: Colors.white,
                              border: border,
                              enabledBorder: border,
                            ),
                            style: bodyFont.copyWith(
                              fontSize: 12,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: inputDecorationRounded().copyWith(
                              hintText: "Password",
                              hintStyle: bodyFont.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              fillColor: Colors.white,
                              border: border,
                              enabledBorder: border,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            style: bodyFont.copyWith(
                              fontSize: 12,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: onSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkPrimaryColor,
                              padding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text("Masuk"),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
