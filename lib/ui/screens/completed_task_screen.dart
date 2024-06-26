import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/completed_task_controller.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  CompletedTaskController completedTaskController =
      Get.find<CompletedTaskController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    completedTaskController.getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child:
                  GetBuilder<CompletedTaskController>(builder: (completedTask) {
                return Visibility(
                  visible: completedTask.getCompletedTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: completedTask.taskListModel.taskList == null ||
                          completedTask.taskListModel.taskList!.isEmpty
                      ? const Center(
                          child: Text('No completed tasks available',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey)))
                      : RefreshIndicator(
                          onRefresh: completedTask.getCompletedTaskList,
                          child: ListView.builder(
                            itemCount:
                                completedTask.taskListModel.taskList?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              return TaskItemCard(
                                showProgress: (inProgress) {
                                  completedTask.getCompletedTaskInProgress =
                                      inProgress;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                status: 'Completed',
                                color: Colors.greenAccent,
                                task: completedTaskController
                                    .taskListModel.taskList![index],
                                onStatusChange: () {
                                  completedTaskController
                                      .getCompletedTaskList();
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
