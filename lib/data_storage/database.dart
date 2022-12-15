import 'package:hive_flutter/hive_flutter.dart';

class TaskDatabase {
  List taskList = [];
  final _taskBox = Hive.box('taskBox');

  //этот метод необходимо запускать, если приложение открывается впервые
  void createInitialData (){
    taskList = [
      ['Ввести первые задачи', false],
    ];
  }

  //загрузить данные из базы
  void loadData(){
    taskList = _taskBox.get("TASKBOX");
  }
  //обновить базу
  void updateDataBase(){
    _taskBox.put("TASKBOX", taskList);
  }



}