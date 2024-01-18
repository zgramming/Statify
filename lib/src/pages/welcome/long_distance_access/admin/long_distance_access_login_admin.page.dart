import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';

class LoginLDAAdminPage extends ConsumerStatefulWidget {
  const LoginLDAAdminPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  ConsumerState<LoginLDAAdminPage> createState() => _LoginLDAAdminPageState();
}

class _LoginLDAAdminPageState extends ConsumerState<LoginLDAAdminPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscureText = true;

  Future<void> onSubmit(String? passwordAdmin) async {
    try {
      final validate = _formKey.currentState?.validate() ?? false;
      if (!validate) return;
      final username = usernameController.text;
      final password = passwordController.text;

      if (passwordAdmin == null) {
        showSnackbar(
          context: context,
          message: "Password admin from server is null",
          backgroundColor: Colors.red,
        );
        return;
      }

      final isValidUser = username == "admin" && password == passwordAdmin;
      if (!isValidUser) {
        showSnackbar(
          context: context,
          message: "Username or password is invalid",
          backgroundColor: Colors.red,
        );
        return;
      }

      context.pushReplacementNamed(
        routeLDAAdminPage,
        pathParameters: {
          "idMachine": widget.idMachine,
        },
      );
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
    final machine =
        ref.watch(CustomProvider.getMachineByIdProvider(widget.idMachine));

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
                    _BackgroundImage(logo: machine?.logo),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
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
                          obscureText: isObscureText,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => onSubmit(machine?.config?.adminPassword),
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

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
    required this.logo,
  }) : super(key: key);

  final String? logo;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      logo ?? "",
      width: 100,
      height: 100,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          kURLLogoHitech,
          width: 100,
          height: 100,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(
              Icons.error,
              size: 50.0,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
