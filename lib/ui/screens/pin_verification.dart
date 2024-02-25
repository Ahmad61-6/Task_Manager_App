import 'package:flutter/material.dart';

import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';

import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'reset_password.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
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
                    "PIN Verification",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    "A 6 digit verification pin will send to your\nemail address",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      activeColor: Colors.greenAccent,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
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
                                      const ResetPasswordScreen()));
                        },
                        child: const Text("Verify")),
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
