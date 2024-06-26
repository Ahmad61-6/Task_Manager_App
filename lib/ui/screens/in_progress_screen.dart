import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/task_in_progress_controller.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<TaskInProgressController>().getProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: GetBuilder<TaskInProgressController>(
                  builder: (inProgressTask) {
                return Visibility(
                  visible: inProgressTask.taskProgressInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: inProgressTask.taskListModel.taskList == null ||
                          inProgressTask.taskListModel.taskList!.isEmpty
                      ? const Center(
                          child: Text('No task is in Progress',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey)))
                      : RefreshIndicator(
                          onRefresh: inProgressTask.getProgressTasks,
                          child: ListView.builder(
                            itemCount:
                                inProgressTask.taskListModel.taskList?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              return TaskItemCard(
                                showProgress: (inProgress) {
                                  inProgressTask.taskProgressInProgress =
                                      inProgress;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                status: 'In Progress',
                                color: Colors.orangeAccent,
                                task: inProgressTask
                                    .taskListModel.taskList![index],
                                onStatusChange: () {
                                  inProgressTask.getProgressTasks();
                                },
                              );
                            },
                          ),
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
