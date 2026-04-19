import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Название"),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Описание (необязательно)",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
