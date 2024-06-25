import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data.network_caller/models/task_count.dart';
import 'package:task_manager_app/ui/controllers/task_count_summery_controller.dart';
import 'package:task_manager_app/ui/widgets/card_widget.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

import '../controllers/new_task_controller.dart';
import "add_new_task_screen.dart";

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool taskCountChange = false;
  NewTaskController newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<NewTaskController>().getNewTaskList();
    Get.find<TaskCountSummeryController>().getTaskCountSummeryList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Navigator.pop(context, taskCountChange);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final response = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewTaskScreen()));
            if (response != null && response == true) {
              Get.find<TaskCountSummeryController>().getTaskCountSummeryList();
            }
          },
          backgroundColor: Colors.green,
          child: const Icon(
            CupertinoIcons.add_circled_solid,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummeryCard(),
              GetBuilder<TaskCountSummeryController>(
                  builder: (taskCountSummeryController) {
                return Visibility(
                    visible: taskCountSummeryController
                                .getTaskCountSummeryInProgress ==
                            false &&
                        (taskCountSummeryController.taskCountSummeryListModel
                                .taskCountList?.isNotEmpty ??
                            false),
                    replacement: const LinearProgressIndicator(),
                    child: SizedBox(
                      height: 120,
                      child: RefreshIndicator(
                        onRefresh: () => taskCountSummeryController
                            .getTaskCountSummeryList(),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: taskCountSummeryController
                                    .taskCountSummeryListModel
                                    .taskCountList
                                    ?.length ??
                                0,
                            itemBuilder: (context, index) {
                              TaskCount taskCount = taskCountSummeryController
                                  .taskCountSummeryListModel
                                  .taskCountList![index];
                              return FittedBox(
                                  child: CardWidget(
                                      count: taskCount.sum.toString(),
                                      status: taskCount.sId ?? ''));
                            }),
                      ),
                    ));
              }),
              Expanded(
                child:
                    GetBuilder<NewTaskController>(builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.getNewTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () => newTaskController.getNewTaskList(),
                      child: ListView.builder(
                        itemCount:
                            newTaskController.taskListModel.taskList?.length ??
                                0,
                        itemBuilder: (context, index) {
                          int reverseIndex =
                              newTaskController.taskListModel.taskList!.length -
                                  1 -
                                  index;
                          return TaskItemCard(
                            showProgress: (inProgress) {
                              Get.find<TaskCountSummeryController>()
                                  .setTaskCountSummeryInProgress(inProgress);
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            status: "new",
                            color: Colors.blue,
                            task: newTaskController
                                .taskListModel.taskList![reverseIndex],
                            onStatusChange: () {
                              newTaskController.getNewTaskList();
                              Get.find<TaskCountSummeryController>()
                                  .getTaskCountSummeryList();
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
      ),
    );
  }
}
