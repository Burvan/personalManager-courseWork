import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;
  Function(BuildContext)? deleteFunction;

  HabitTile(
      {Key? key,
      required this.habitName,
      required this.onTap,
      required this.settingsTapped,
      required this.timeSpent,
      required this.timeGoal,
      required this.habitStarted,
      required this.deleteFunction})
      : super(key: key);

  //если секунд больше 60, нужно привести к виду мин-сек
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    if (secs.length == 1) {
      secs = '0' + secs;
    }

    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return mins + ':' + secs;
  }

  //прогресс в процентах
  double percentCompleted() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(12),
                  onPressed: deleteFunction,
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
              ),
            ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.indigo[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //circle radius
              Row(
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Stack(
                          children: [
                            CircularPercentIndicator(
                              radius: 30,
                              percent:
                                  percentCompleted() < 1 ? percentCompleted() : 1,
                              progressColor: percentCompleted() > 0.5
                                  ? (percentCompleted() > 0.75
                                      ? (percentCompleted() == 1.00
                                          ? Colors.green
                                          : Colors.greenAccent)
                                      : Colors.orange)
                                  : Colors.red,
                            ),
                            //pause button
                            Center(
                              child: Icon(
                                habitStarted ? Icons.pause : Icons.play_arrow,
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //habit name
                      Text(
                        habitName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                        ),
                      ),
                      //progress
                      const SizedBox(height: 4),
                      Text(
                        '${formatToMinSec(timeSpent)} / $timeGoal.00 = ${(percentCompleted() * 100).toStringAsFixed(0)} % ',
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: settingsTapped,
                child: Icon(Icons.settings, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
