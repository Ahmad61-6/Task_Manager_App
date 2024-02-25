import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(
              title: "Ahmad",
              subtitle: "ahmad@gmail.com",
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskItemCard(
                    status: "Completed",
                    color: Colors.greenAccent,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
