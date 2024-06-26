import 'package:get/get.dart';

import '../../data.network_caller/models/task_list_model.dart';
import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/network_response.dart';
import '../../data.network_caller/utility/urls.dart';

class CancelTaskController extends GetxController {
  bool taskCanceledInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCanceledTasks() async {
    bool isSuccess = false;
    taskCanceledInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCanceledTasks);
    taskCanceledInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
