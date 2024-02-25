import 'package:flutter/material.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/screens/new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Column(
            children: [
              const ProfileSummeryCard(
                title: "Ahmad",
                subtitle: "ahmad@gmail.com",
              ),
              Expanded(
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
                        "Add New Task",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFormFieldDecoration("Subject"),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        maxLines: 5,
                        decoration: textFormFieldDecoration("Description"),
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
                                          const NewTaskScreen()),
                                  (route) => false);
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
