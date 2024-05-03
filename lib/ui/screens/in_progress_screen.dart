import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

import '../../data.network_caller/models/task_list_model.dart';
import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/network_response.dart';
import '../../data.network_caller/utility/urls.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  bool taskProgressInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getProgressTasks() async {
    taskProgressInProgress = true;
    if (mounted) {
      setState(() {});
      final NetworkResponse response =
          await NetworkCaller().getRequest(Urls.getProgressTasks);
      if (response.isSuccess) {
        taskListModel = TaskListModel.fromJson(response.jsonResponse);
      }
      taskProgressInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProgressTasks();
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
                visible: taskProgressInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getProgressTasks,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                          status: 'Canceled',
                          color: Colors.orangeAccent,
                          task: taskListModel.taskList![index]);
                      // return const TaskItemCard(
                      //   status: "Progress",
                      //   color: Colors.purple,
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
