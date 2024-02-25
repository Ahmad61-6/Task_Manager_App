import 'package:flutter/material.dart';
import "add_new_task_screen.dart";
import 'package:task_manager_app/ui/widgets/card_widget.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(
              title: "Ahmad",
              subtitle: "ahmad@gmail.com",
            ),
            const SingleChildScrollView(
              padding: EdgeInsets.only(left: 16.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardWidget(
                    count: "92",
                    status: "Canceled",
                  ),
                  CardWidget(
                    count: "92",
                    status: "Completed",
                  ),
                  CardWidget(
                    count: "92",
                    status: "Progress",
                  ),
                  CardWidget(
                    count: "92",
                    status: "New Task",
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskItemCard(
                    status: "new",
                    color: Colors.blue,
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
