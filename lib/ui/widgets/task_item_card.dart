import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/ui/widgets/snack_massage.dart';

import '../../data.network_caller/models/task.dart';
import '../../data.network_caller/utility/urls.dart';

enum TaskStatus { Completed, New, Canceled, Progress }

class TaskItemCard extends StatefulWidget {
  final String status;
  final Color color;
  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  const TaskItemCard({
    Key? key,
    required this.status,
    required this.color,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
  }) : super(key: key);

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  Future<void> deleteTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.deleteTasks(widget.task.sId ?? ''));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(widget.task.description ?? ''),
            const SizedBox(
              height: 5,
            ),
            Text('Date: ${widget.task.createdDate}'),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: widget.color,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Delete!"),
                                    Text(
                                      "Once you delete, you can't get it back.",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                                  ],
                                ),
                                content: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          deleteTaskStatus(
                                              widget.task.sId ?? "");
                                          if (mounted) {
                                            showSnackMessage(context,
                                                "Task Deleted Successfully!");
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 16),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "No",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16),
                                        )),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showUpdateTaskModal();
                        },
                        icon: const Icon(CupertinoIcons.pencil_circle_fill,
                            size: 30, color: Colors.green))
                  ],
                )
              ],
            )
            // Your card content goes here
          ],
        ),
      ),
    );
  }

  void showUpdateTaskModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Update Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.blueGrey)),
                  ),
                ],
              )
            ],
          );
        });
  }
}
