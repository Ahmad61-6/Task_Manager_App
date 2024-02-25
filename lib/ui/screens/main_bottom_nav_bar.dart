// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cancel_task_screen.dart';
import 'new_task_screen.dart';
import 'in_progress_screen.dart';
import 'completed_task_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screen = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CancelTaskScreen(),
    const InProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "New Task"),
          BottomNavigationBarItem(
              icon: Icon(Icons.task_alt), label: "Completed"),
          BottomNavigationBarItem(
              icon: Icon(Icons.free_cancellation_outlined), label: "Canceled"),
          BottomNavigationBarItem(
              icon: Icon(Icons.task_sharp), label: "Progress")
        ],
      ),
    );
  }
}
