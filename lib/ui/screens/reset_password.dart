import 'package:flutter/material.dart';

import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';

import 'package:task_manager_app/ui/widgets/body_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    "Set Password",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Minimum length password 8 character with\n"
                    "letter and number combination",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: textFormFieldDecoration("New Password"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: textFormFieldDecoration("Confirm Password"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: ElevatedButton(
                        style: appButtonStyle(),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()),
                              (route) => false);
                        },
                        child: const Text("Confirm")),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account!",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                                (route) => false);
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.greenAccent),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
