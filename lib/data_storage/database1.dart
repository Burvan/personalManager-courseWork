import 'package:hive_flutter/hive_flutter.dart';

class HabitDatabase {
  List habitList = [];
  final _habitBox = Hive.box('habitBox');

  //этот метод необходимо запускать, если приложение открывается впервые
  void create1InitialData (){
    habitList = [
      ['My first habit', false, 0, 5],
    ];
  }

  //загрузить данные из базы
  void load1Data(){
    habitList = _habitBox.get("HABITBOX");
  }
  //обновить базу
  void update1DataBase(){
    _habitBox.put("HABITBOX", habitList);
  }



}