import 'package:flutter/material.dart';
import 'package:task_manager_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/network_response.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

import '../../data.network_caller/utility/urls.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool taskCanceledInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCanceledTasks() async {
    taskCanceledInProgress = true;
    if (mounted) {
      setState(() {});
      final NetworkResponse response =
          await NetworkCaller().getRequest(Urls.getCanceledTasks);
      if (response.isSuccess) {
        taskListModel = TaskListModel.fromJson(response.jsonResponse);
      }
      taskCanceledInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCanceledTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: Visibility(
                visible: taskCanceledInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getCanceledTasks,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                          status: 'Canceled',
                          color: Colors.redAccent,
                          task: taskListModel.taskList![index]);
                      // return const TaskItemCard(
                      //   status: "Canceled",
                      //   color: Colors.redAccent,
                      // );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
