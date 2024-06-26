import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/cancel_task_controller.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';

import '../widgets/task_item_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  CancelTaskController cancelTaskController = Get.find<CancelTaskController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cancelTaskController.getCanceledTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: GetBuilder<CancelTaskController>(builder: (cancelTask) {
                return Visibility(
                  visible: cancelTask.taskCanceledInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: cancelTask.taskListModel.taskList == null ||
                          cancelTask.taskListModel.taskList!.isEmpty
                      ? const Center(
                          child: Text('No canceled tasks available',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey)),
                        )
                      : RefreshIndicator(
                          onRefresh: cancelTask.getCanceledTasks,
                          child: ListView.builder(
                            itemCount:
                                cancelTask.taskListModel.taskList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return TaskItemCard(
                                showProgress: (inProgress) {
                                  cancelTask.taskCanceledInProgress =
                                      inProgress;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                status: 'Canceled',
                                color: Colors.redAccent,
                                task: cancelTaskController
                                    .taskListModel.taskList![index],
                                onStatusChange: () {
                                  () => cancelTaskController.getCanceledTasks();
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
