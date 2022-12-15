import 'package:flutter/material.dart';
import 'package:my_course_work/screens/appointments/appointments.dart';
import 'package:my_course_work/screens/appointments/event_provider.dart';
import 'package:my_course_work/screens/tasks/tasks_page.dart';
import 'package:my_course_work/screens/time_manager/home_page.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  //объявление локальной базы данных
  await Hive.initFlutter();

  var boxTasks = await Hive.openBox('taskBox');
  //var boxHabits = await Hive.openBox('habitBox');
  runApp(ChangeNotifierProvider(
    create: (context) => EventProvider(),
    child: MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const TasksPage(),
        '/appointments': (context) => const Appointments(),
        '/time_manager': (context) => const HomePage(),
        //'/tasks': (context) => const Task(),
      },
    ),
  ),
  );
}
