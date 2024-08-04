// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:superstore/services/auth/repo/auth_repo.dart';
import 'package:superstore/services/local_storage/shared_model.dart';
import 'package:superstore/services/singleton/singleton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _email;
  bool passwordObscure = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initEmail();
  }

  _initEmail() async {
    final res = await SharedModel.getEmail();
    if (res != null) {
      setState(() {
        _email = res;
      });
      _emailController.text = _email!;
    }
  }

  _togglePasswordObsucre() {
    setState(() {
      passwordObscure = !passwordObscure;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      try {
        final res = await singleton<AuthRepository>().loginWithEmailPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (res.user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Wrong credential",
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          );
        }
      } on FirebaseException catch (err) {
        throw Exception(err.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        actions: const [
          // BlocBuilder<ThemeBloc, ThemeState>(
          //   builder: (context, state) {
          //     return CupertinoSwitch(
          //         value: state.isDarkModel,
          //         onChanged: (_) {
          //           context.read<ThemeBloc>().add(
          //                 ToggleThemeEvent(),
          //               );
          //         });
          //   },
          // ),
          Gap(16),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.bakery_dining_outlined,
                  size: 120,
                  color: Colors.brown,
                ),
                const Gap(20),
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.blueAccent,
                    ),
                    hintText: "email...",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !EmailValidator.validate(value)) {
                      return "no email or invalide email";
                    }
                    return null;
                  },
                ),
                const Gap(20),
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.blueAccent,
                    ),
                    hintText: "password...",
                    suffix: IconButton(
                      onPressed: _togglePasswordObsucre,
                      icon: passwordObscure
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.blue,
                            )
                          : const Icon(
                              Icons.visibility_off,
                            ),
                    ),
                  ),
                  obscureText: passwordObscure,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "password must more than 6 characters";
                    }
                    return null;
                  },
                ),
                const Gap(20),
                TextButton(
                  onPressed: _login,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
