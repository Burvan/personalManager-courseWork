import 'package:flutter/material.dart';
import 'package:my_course_work/screens/time_manager/models/habit.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({Key? key}) : super(key: key);

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final TextEditingController textEditingControllerName =
      TextEditingController();
  int timeGoal = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.indigo[400],
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Добавить новую привычку'
            ),
            controller: textEditingControllerName,
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              MaterialButton(
                minWidth: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                color: Colors.indigo[300],
                onPressed: () {
                  if(timeGoal > 1) {
                    setState(() {
                      timeGoal--;
                    });
                  }
                },
                child: const Icon(Icons.exposure_minus_1),
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    //color: Colors.indigo[300],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text('$timeGoal'),
                  ),
                ),
              ),
              const Spacer(),
              MaterialButton(
                minWidth: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                color: Colors.indigo[300],
                onPressed: () {
                  setState(() {
                    timeGoal++;
                  });

                },
                child: const Icon(Icons.plus_one, color: Colors.white,),
              ),
            ],
          ),
          const Spacer(),
          MaterialButton(
            color: Colors.indigo[300],
            onPressed: () {
              final habit = Habit(title: textEditingControllerName.text, isAlreadyComplete: false,
              timeSpent: 0, timeGoal: timeGoal);
               Navigator.pop(context, habit);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
