import 'package:flutter/material.dart';
import 'package:task_manager_app/data.network_caller/models/task_count.dart';
import 'package:task_manager_app/data.network_caller/models/task_count_summery_list_model.dart';
import 'package:task_manager_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/network_response.dart';
import 'package:task_manager_app/data.network_caller/utility/urls.dart';
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
  bool getNewTaskInProgress = false;
  bool getTaskCountSummeryInProgress = false;
  TaskListModel taskListModel = TaskListModel();
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

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewTaskList();
    getTaskCountSummeryList();
  }

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
            Visibility(
                visible: getTaskCountSummeryInProgress == false &&
                    (taskCountSummeryListModel.taskCountList?.isNotEmpty ??
                        false),
                replacement: const LinearProgressIndicator(),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          taskCountSummeryListModel.taskCountList?.length ?? 0,
                      itemBuilder: (context, index) {
                        TaskCount taskCount =
                            taskCountSummeryListModel.taskCountList![index];
                        return FittedBox(
                            child: CardWidget(
                                count: taskCount.sum.toString(),
                                status: taskCount.sId ?? ''));
                      }),
                )),
            Expanded(
              child: Visibility(
                visible: getNewTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        taskListModel.taskList!.length - 1 - index;
                    return TaskItemCard(
                      status: "new",
                      color: Colors.blue,
                      task: taskListModel.taskList![reverseIndex],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
