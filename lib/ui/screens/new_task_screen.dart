import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data.network_caller/models/task_count.dart';
import 'package:task_manager_app/data.network_caller/models/task_count_summery_list_model.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/network_response.dart';
import 'package:task_manager_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_app/ui/contollers/new_task_controller.dart';
import 'package:task_manager_app/ui/widgets/card_widget.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

import "add_new_task_screen.dart";

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getTaskCountSummeryInProgress = false;
  bool taskCountChange = false;
  TaskCountSummeryListModel taskCountSummeryListModel =
      TaskCountSummeryListModel();

  Future<void> getTaskCountSummeryList() async {
    getTaskCountSummeryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskCountSummeryListModel =
          TaskCountSummeryListModel.fromJson(response.jsonResponse);
    }
    getTaskCountSummeryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<NewTaskController>().getNewTaskList();
    getTaskCountSummeryList();
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
              Get.find<NewTaskController>().getNewTaskList();
              getTaskCountSummeryList();
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
              Visibility(
                  visible: getTaskCountSummeryInProgress == false &&
                      (taskCountSummeryListModel.taskCountList?.isNotEmpty ??
                          false),
                  replacement: const LinearProgressIndicator(),
                  child: SizedBox(
                    height: 120,
                    child: RefreshIndicator(
                      onRefresh: getTaskCountSummeryList,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              taskCountSummeryListModel.taskCountList?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            TaskCount taskCount =
                                taskCountSummeryListModel.taskCountList![index];
                            return FittedBox(
                                child: CardWidget(
                                    count: taskCount.sum.toString(),
                                    status: taskCount.sId ?? ''));
                          }),
                    ),
                  )),
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
                              getTaskCountSummeryInProgress = inProgress;
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
                              getTaskCountSummeryList();
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
