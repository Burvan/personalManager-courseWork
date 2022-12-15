import 'package:flutter/material.dart';

import 'models/habit.dart';

class Settings extends StatefulWidget {
  final Habit habit;

  const Settings({Key? key, required this.habit}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late int timeGoal = widget.habit.timeGoal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: <Widget>[
          const Text(
            'TimeGoal',
             style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold
             ),
          ),
          const SizedBox(height: 10),
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
                flex: 7,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
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
            minWidth: 100,
            height: 40,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            color: Colors.indigo[300],
            onPressed: () {
              final habit = widget.habit.copyWith(timeGoal: timeGoal);
              Navigator.pop(context, habit);
            },
              child: const Text('Изменить'),
          ),

        ],
      ),
    );
  }
}
