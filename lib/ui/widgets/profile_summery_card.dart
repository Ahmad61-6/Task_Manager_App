import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';

import '../controllers/auth_controller.dart';

class ProfileSummeryCard extends StatefulWidget {
  const ProfileSummeryCard({
    super.key,
    this.enableOnTap = true,
    this.showTrailingIcon = true,
  });
  final bool enableOnTap, showTrailingIcon;

  @override
  State<ProfileSummeryCard> createState() => _ProfileSummeryCardState();
}

class _ProfileSummeryCardState extends State<ProfileSummeryCard> {
  final Color color = const Color(0xFF2E8B57);
  bool logOutInProgress = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      Uint8List imageBytes =
          const Base64Decoder().convert(authController.user?.photo ?? '');
      return ListTile(
        onTap: () {
          if (widget.enableOnTap) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()));
          }
        },
        leading: authController.user?.photo == null
            ? const CircleAvatar(
                child: Icon(Icons.person_outline),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.memory(imageBytes, fit: BoxFit.cover),
              ),
        title: Text(
          authController.user?.firstName ?? '',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          authController.user?.email ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: () async {
            await AuthController.clearAuthData();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (route) => false);
            }
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white70,
          ),
        ),
        tileColor: Colors.green,
      );
    });
  }
}
