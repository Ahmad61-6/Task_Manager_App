import 'dart:convert';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data.network_caller/models/user_model.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/network_response.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/snack_massage.dart';

import '../../data.network_caller/utility/urls.dart';
import '../controllers/auth_controller.dart';

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
  AuthController authController = Get.find<AuthController>();

  bool _updateProfileInProgress = false;

  XFile? photo;
  XFile? galleryFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEController.text = authController.user?.email ?? '';
    _firstNameTEController.text = authController.user?.firstName ?? '';
    _lastNameTEController.text = authController.user?.lastName ?? '';
    _numberTEController.text = authController.user?.mobile ?? '';
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
                        photoPickerField(),
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
      String? photoInBase64;
      Map<String, dynamic> inputData = {
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "email": _emailTEController.text.trim(),
        "mobile": _numberTEController.text.trim(),
      };

      if (_passwordTEController.text.isNotEmpty) {
        inputData['password'] = _passwordTEController.text;
      }

      if (photo != null) {
        List<int> imageBytes = await photo!.readAsBytes();
        photoInBase64 = base64Encode(imageBytes);
        inputData['photo'] = photoInBase64;
      }

      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.updateProfile,
        body: inputData,
      );
      _updateProfileInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        authController.updateUserInformation(UserModel(
            email: _emailTEController.text.trim(),
            firstName: _firstNameTEController.text.trim(),
            lastName: _lastNameTEController.text.trim(),
            mobile: _numberTEController.text.trim(),
            photo: photoInBase64 ?? authController.user?.photo));
        if (mounted) {
          showSnackMessage(context, 'Update profile success!');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Update profile failed. Try again.');
        }
      }
    }
  }

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
                    bottomLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                _showPicker(context: context);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: photo == null,
                  replacement: Text(photo?.name ?? ''),
                  child: const Text('Select a photo'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource img) async {
    final XFile? image = await ImagePicker().pickImage(source: img);
    if (image != null) {
      photo = image;
      if (mounted) {
        setState(() {});
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
