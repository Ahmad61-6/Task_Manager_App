import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
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
                  // return const TaskItemCard(
                  //   status: "Canceled",
                  //   color: Colors.redAccent,
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
