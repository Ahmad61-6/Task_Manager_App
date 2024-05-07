import 'package:flutter/material.dart';
import 'package:task_manager_app/data.network_caller/models/user_model.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/network_response.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/contollers/auth_controller.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/snack_massage.dart';

import '../../data.network_caller/utility/urls.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _numberTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateProfileInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEController.text = AuthController.user?.email ?? '';
    _firstNameTEController.text = AuthController.user?.firstName ?? '';
    _lastNameTEController.text = AuthController.user?.lastName ?? '';
    _numberTEController.text = AuthController.user?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(
              enableOnTap: false,
            ),
            Expanded(
                child: BodyBackground(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Update Profile",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8))),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Photos",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                              const SizedBox(
                                width: 4,
                              ),
                              const Expanded(flex: 3, child: Text("empty"))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _emailTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormFieldDecoration("Email"),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Please enter the Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _firstNameTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormFieldDecoration("First Name"),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'First name is not entered!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _lastNameTEController,
                          keyboardType: TextInputType.phone,
                          decoration: textFormFieldDecoration("Last Name"),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Last name is not entered!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _numberTEController,
                          decoration: textFormFieldDecoration("Mobile"),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Mobile number is not entered!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _passwordTEController,
                          obscureText: true,
                          decoration:
                              textFormFieldDecoration("Password (Optional)"),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 38,
                          child: Visibility(
                            visible: _updateProfileInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                                style: appButtonStyle(),
                                onPressed: updateProfile,
                                child: const Icon(
                                    Icons.arrow_circle_right_outlined)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _updateProfileInProgress = true;
      if (mounted) {
        setState(() {});
      }
      Map<String, dynamic> inputData = {
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _numberTEController.text.trim(),
        "photo": ""
      };
      if (_passwordTEController.text.isNotEmpty) {
        inputData['password'] = _passwordTEController.text;
      }
      final NetworkResponse response = await NetworkCaller()
          .postRequest(Urls.updateProfile, body: inputData);
      _updateProfileInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        AuthController.updateUserInformation(UserModel(
          email: _emailTEController.text.trim(),
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          mobile: _numberTEController.text.trim(),
        ));
        if (mounted) {
          showSnackMessage(context, 'Profile Updated Successfully!');
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, 'Profile Update Unsuccessful! Please try again!');
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _numberTEController.dispose();
    super.dispose();
  }
}
