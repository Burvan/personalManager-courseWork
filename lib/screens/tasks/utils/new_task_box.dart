import 'package:flutter/material.dart';

import 'package:my_course_work/screens/tasks/utils/my_buttons.dart';

class NewTaskBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  NewTaskBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.indigo[400],
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Добавить новую задачу'
              ),
              controller: controller,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(text: 'Сохранить', onPressed: onSave),
                MyButton(text: 'Отменить', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
