import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/contollers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';

class ProfileSummeryCard extends StatefulWidget {
  const ProfileSummeryCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.enableOnTap = true,
    this.showTrailingIcon = true,
  });
  final String title, subtitle;
  final bool enableOnTap, showTrailingIcon;

  @override
  State<ProfileSummeryCard> createState() => _ProfileSummeryCardState();
}

class _ProfileSummeryCardState extends State<ProfileSummeryCard> {
  final Color color = const Color(0xFF2E8B57);

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
      title: Text(
        widget.title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        widget.subtitle,
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
      tileColor: color,
    );
  }
}
