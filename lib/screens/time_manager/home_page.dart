import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_course_work/BottomBar/bottom_bar.dart';
import 'package:my_course_work/screens/time_manager/add_habit.dart';
import 'package:my_course_work/screens/time_manager/habit_tile.dart';
import 'package:my_course_work/screens/time_manager/models/habit.dart';
import 'package:my_course_work/screens/time_manager/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Habit> habitList = [
    //название, началось ли выполнение, уже выполнил(сек), всего надо (мин)
    Habit(
        title: 'Training', isAlreadyComplete: false, timeSpent: 0, timeGoal: 20),
    Habit(
        title: 'Programming',
        isAlreadyComplete: false,
        timeSpent: 0,
        timeGoal: 45),
    Habit(
        title: 'Day sleeping',
        isAlreadyComplete: false,
        timeSpent: 0,
        timeGoal: 20),
    Habit(
        title: 'English reading',
        isAlreadyComplete: false,
        timeSpent: 0,
        timeGoal: 2),

    // ['Training', false, 0, 1],
    // ['Programming', false, 0, 45],
    // ['Day sleeping', false, 0, 20],
    // ['English reading', false, 0, 2],
  ];

  void habitStarted(int index) {
    var startTime = DateTime.now();

    //надо учесть время, которое уже прошло
    int elapsedTime = habitList[index].timeSpent;
    //habit started or stopped
    List<Habit> newHabitList = List.of(habitList);
    newHabitList[index] = habitList[index].copyWith(
      isAlreadyComplete: !habitList[index].isAlreadyComplete,
    );
    setState(() {
      habitList[index] = newHabitList[index];
    });
    var counter = habitList[index].timeGoal * 60;

    if (habitList[index].isAlreadyComplete) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        counter--;
        setState(() {
          if (!habitList[index].isAlreadyComplete) {
            timer.cancel();
          }
          //расчёт времени, прошедшего между текущим временем и начальным
          var currentTime = DateTime.now();
          newHabitList[index] = habitList[index].copyWith(
            timeSpent: elapsedTime +
                currentTime.second -
                startTime.second +
                60 * (currentTime.minute - startTime.minute) +
                60 * 60 * (currentTime.hour - startTime.hour),
          );
          habitList[index] = newHabitList[index];

          // habitList[index][2] = elapsedTime +
          //     currentTime.second -
          //     startTime.second +
          //     60 * (currentTime.minute - startTime.minute) +
          //     60 * 60 * (currentTime.hour - startTime.hour);
          if (counter == 0) {
            newHabitList[index] = habitList[index].copyWith(
              isAlreadyComplete: false,
            );
             habitList[index] = newHabitList[index];

            // habitList[index][2] = 0;
            timer.cancel();
          }
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Settings for ${habitList[index].title}'),
            content: Settings(
              habit: habitList[index],
            ),
          );
        }).then((value) {
      setState(() {
        habitList[index] = value ?? habitList[index];
      });
    });
  }

  void addHabitOpened() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: AddHabit(),
          );
        }).then((value) {
          setState(() {
            habitList.add(value);
          });
    });
  }

  void deleteHabit(int index) {
    setState(() {
      habitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('If you give in once, it' "l become a habit"),
        backgroundColor: Colors.indigo[300],
      ),
      body: ListView.builder(
          itemCount: habitList.length,
          itemBuilder: ((context, index) {
            return HabitTile(
              habitName: habitList[index].title,
              onTap: () {
                habitStarted(index);
              },
              settingsTapped: () {
                settingsOpened(index);
              },
              habitStarted: habitList[index].isAlreadyComplete,
              timeSpent: habitList[index].timeSpent,
              timeGoal: habitList[index].timeGoal,
              deleteFunction: (context) => deleteHabit(index),
            );
          })),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[300],
        onPressed: () {
          addHabitOpened();
        },
        child: const Icon(Icons.add_box_rounded, color: Colors.white),
      ),
    );
  }
}
