import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.count,
    required this.status,
  });
  final String count, status;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Text(status)
          ],
        ),
      ),
    );
  }
}
