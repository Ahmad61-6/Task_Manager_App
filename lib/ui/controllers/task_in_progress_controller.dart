import 'package:get/get.dart';

import '../../data.network_caller/models/task_list_model.dart';
import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/network_response.dart';
import '../../data.network_caller/utility/urls.dart';

class TaskInProgressController extends GetxController {
  bool taskProgressInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getProgressTasks() async {
    bool isSuccess = false;
    taskProgressInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTasks);
    taskProgressInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
