import 'package:flutter/material.dart';

import 'package:task_manager_app/style.dart';

import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'pin_verification.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
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
                    "Your Email Address",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "A 6 digit verification pin will send to your\nemail address",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: textFormFieldDecoration("Email"),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PinVerificationScreen()));
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined)),
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
                            Navigator.pop(context);
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
