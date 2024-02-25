import 'package:flutter/material.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(
              title: "Ahmad",
              subtitle: "ahmadmizan210@gmail.com",
              enableOnTap: false,
            ),
            Expanded(
                child: BodyBackground(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: SingleChildScrollView(
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFormFieldDecoration("Email"),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFormFieldDecoration("First Name"),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: textFormFieldDecoration("Last Name"),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: textFormFieldDecoration("Mobile"),
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
                            onPressed: () {},
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
