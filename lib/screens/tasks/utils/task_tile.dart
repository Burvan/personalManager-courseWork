import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TaskTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction
  });



  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: StretchMotion(),
        children: [
          SlidableAction(

            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),

          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.indigo[100],
            borderRadius: BorderRadius.circular(10),

          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black45,
              ),
              Text(
                taskName,
                style: TextStyle(
                    decoration: taskCompleted ? TextDecoration.lineThrough :
                    TextDecoration.none,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
