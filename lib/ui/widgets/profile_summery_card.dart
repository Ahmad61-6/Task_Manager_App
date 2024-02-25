import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';

class ProfileSummeryCard extends StatelessWidget {
  const ProfileSummeryCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.enableOnTap = true,
    this.showTrailingIcon = true,
  });
  final String title, subtitle;
  final Color color = const Color(0xFF2E8B57);
  final bool enableOnTap, showTrailingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (enableOnTap) {
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
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(
        Icons.arrow_forward,
        color: Colors.white70,
      ),
      tileColor: color,
    );
  }
}
