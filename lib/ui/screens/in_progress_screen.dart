import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
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
                    status: "Progress",
                    color: Colors.purple,
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
