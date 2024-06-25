import 'package:get/get.dart';

import '../../data.network_caller/models/task_count_summery_list_model.dart';
import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/network_response.dart';
import '../../data.network_caller/utility/urls.dart';

class TaskCountSummeryController extends GetxController {
  bool _getTaskCountSummeryInProgress = false;
  TaskCountSummeryListModel _taskCountSummeryListModel =
      TaskCountSummeryListModel();

  bool get getTaskCountSummeryInProgress => _getTaskCountSummeryInProgress;
  void setTaskCountSummeryInProgress(bool inProgress) =>
      _getTaskCountSummeryInProgress = inProgress;
  TaskCountSummeryListModel get taskCountSummeryListModel =>
      _taskCountSummeryListModel;
  Future<bool> getTaskCountSummeryList() async {
    bool isSuccess = false;
    _getTaskCountSummeryInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    _getTaskCountSummeryInProgress = false;
    if (response.isSuccess) {
      _taskCountSummeryListModel =
          TaskCountSummeryListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
