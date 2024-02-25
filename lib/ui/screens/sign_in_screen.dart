import 'package:flutter/material.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_bar.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';

import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'forgot_password_email.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Get Started With",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEController,
                      decoration: textFormFieldDecoration("Email"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: textFormFieldDecoration("Password"),
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
                                    builder: (context) =>
                                        const MainBottomNavBar()),
                                (route) => false);
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordEmailScreen()));
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.greenAccent),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
