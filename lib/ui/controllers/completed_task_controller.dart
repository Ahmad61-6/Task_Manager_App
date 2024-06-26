import 'package:get/get.dart';
import 'package:task_manager_app/data.network_caller/network_response.dart';

import '../../data.network_caller/models/task_list_model.dart';
import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/utility/urls.dart';

class CompletedTaskController extends GetxController {
  bool getCompletedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  TaskListModel get taskListModel => _taskListModel;
  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    getCompletedTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    getCompletedTaskInProgress = false;
    update();
    return isSuccess;
  }
}
