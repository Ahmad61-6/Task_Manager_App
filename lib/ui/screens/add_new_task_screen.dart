import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/network_response.dart';
import 'package:task_manager_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:task_manager_app/ui/widgets/profile_summery_card.dart';
import 'package:task_manager_app/ui/widgets/snack_massage.dart';

import '../controllers/new_task_controller.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _createTaskInProgress = false;
  bool newTaskAdded = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Navigator.pop(context, newTaskAdded);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummeryCard(),
              Expanded(
                  child: BodyBackground(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            const Text(
                              "Add New Task",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: _subjectTEController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textFormFieldDecoration("Subject"),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Subject should be entered";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _descriptionTEController,
                              maxLines: 5,
                              decoration:
                                  textFormFieldDecoration("Description"),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Description should be entered";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 38,
                              child: Visibility(
                                visible: _createTaskInProgress == false,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: ElevatedButton(
                                    style: appButtonStyle(),
                                    onPressed: createTask,
                                    child: const Icon(
                                        Icons.arrow_circle_right_outlined)),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if (_formKey.currentState!.validate()) {
      _createTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }

      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": _subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status": "New"
      });
      _createTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {
        newTaskAdded = true;
        _subjectTEController.clear();
        _descriptionTEController.clear();
        Get.find<NewTaskController>().getNewTaskList();
        if (mounted) {
          showSnackMessage(context, 'New task added!');
          Navigator.pop(context, newTaskAdded);
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Create new Task failed! Try again.', true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
