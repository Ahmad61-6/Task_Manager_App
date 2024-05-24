import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/contollers/new_task_controller.dart';
import 'package:task_manager_app/ui/contollers/sign_in_controller.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigationKey,
      home: const SplashScreen(),
      initialBinding: ControllerBinders(),
    );
  }
}

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskController());
  }
}
