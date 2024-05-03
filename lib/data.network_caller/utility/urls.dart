class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registrationUrl = '$_baseUrl/registration';
  static const String logInUrl = '$_baseUrl/login';
  static const String createNewTask = '$_baseUrl/createTask';
  static const String getNewTasks = '$_baseUrl/listTaskByStatus/New';
  static const String getProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static const String getCanceledTasks = '$_baseUrl/listTaskByStatus/Canceled';
  static const String getCompletedTasks =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';
}
