import 'package:flutter/material.dart';

class TaskItemCard extends StatelessWidget {
  final String status;
  final Color color;

  const TaskItemCard({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "This is a new task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text("Description"),
            const SizedBox(
              height: 5,
            ),
            const Text("Date: dd-mm-yyyy"),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: color,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_forever_outlined),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
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
}
