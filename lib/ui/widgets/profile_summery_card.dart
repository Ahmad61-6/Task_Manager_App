import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/contollers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';

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
    return ListTile(
      onTap: () {
        if (widget.enableOnTap) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen()));
        }
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person_outline),
      ),
      title: ValueListenableBuilder<String?>(
        valueListenable: AuthController.firstNameNotifier,
        builder: (_, firstName, __) => Text(
          firstName ?? '',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      subtitle: ValueListenableBuilder<String?>(
        valueListenable: AuthController.emailNotifier,
        builder: (_, email, __) => Text(
          email ?? '',
          style: const TextStyle(color: Colors.white),
        ),
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
  }
}
