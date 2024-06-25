import 'package:flutter/material.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:task_manager_app/ui/widgets/snack_massage.dart';

import '../controllers/password_verification_sharedPreference.dart';
import 'pin_verification.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailVTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _emailVerificationInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Your Email Address",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
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
                      controller: _emailVTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: textFormFieldDecoration("Email"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Email field is empty!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 38,
                      child: Visibility(
                        visible: _emailVerificationInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            style: appButtonStyle(),
                            onPressed: () {
                              emailVerification();
                            },
                            child: const Text(
                              "Verify",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
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
      ),
    );
  }

  Future<void> emailVerification() async {
    if (_formKey.currentState!.validate()) {
      _emailVerificationInProgress = true;
      if (mounted) {
        setState(() {});
      }

      // Normalize both email addresses by trimming spaces and converting to lower case

      final response = await NetworkCaller()
          .getRequest(Urls.verifyEmail(_emailVTEController.text));
      _emailVerificationInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        await writeEmailVerification(_emailVTEController.text);
        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PinVerificationScreen()));
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Something went wrong! Please try again');
        }
      }
    } else {
      if (mounted) {
        _emailVerificationInProgress = false;
        setState(() {});
        showSnackMessage(
            context, 'Given Email is not valid! Provide a valid Email');
      }
    }
  }

  @override
  void dispose() {
    _emailVTEController.dispose();
    super.dispose();
  }
}
