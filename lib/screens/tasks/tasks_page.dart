import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_course_work/BottomBar/bottom_bar.dart';
import 'package:my_course_work/data_storage/database.dart';
import 'package:my_course_work/screens/tasks/utils/new_task_box.dart';
import 'package:my_course_work/screens/tasks/utils/task_tile.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  //обратимся к нашему box
  final _taskBox = Hive.box('taskBox');
  TaskDatabase db = TaskDatabase();
  @override
  void initState() {
    //если приложение запускается впервые в жизни, то значения выводятся по умолчанию
    if(_taskBox.get("TASKBOX") == null){
      db.createInitialData();
    }
    else{
      //выводим уже существующие данные
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  // был ли нажат checkBox
  void checkBoxChanged (bool? value, int index){
    setState(() {
      db.taskList[index][1] = !db.taskList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.taskList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void addTask(){
    showDialog(
        context: context,
        builder: (context){
          return NewTaskBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop() ,
          );
        }
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: const Text('You should do this'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: db.taskList.length,
        itemBuilder: (context, index) {
          return TaskTile(
            taskName: db.taskList[index][0],
            taskCompleted: db.taskList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[300],
        onPressed: addTask,
        child: const Icon(
            Icons.add_box_rounded,
            color: Colors.white
        ),
      ),

    );
  }
}
