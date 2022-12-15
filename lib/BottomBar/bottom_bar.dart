import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itRoute = ModalRoute.of(context)?.settings.name;
    ifActiveTasksButton(){
      if(itRoute== '/'){
        return Colors.indigo[300];
      }
    }
    ifActiveAppointmentsButton(){
      if(itRoute== '/appointments'){
        return Colors.indigo[300];
      }
    }
    ifActiveContactsButton(){
      if(itRoute== '/time_manager'){
        return Colors.indigo[300];
      }
    }
    // ifActiveTasks1Button(){
    //   if(itRoute== '/tasks'){
    //     return Colors.greenAccent[100];
    //   }
    // }

    return Row(
      children: [
        //КНОПКА встречи
        Material(
          color: ifActiveAppointmentsButton() ,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          child: InkWell(
            onTap: (){
              if(itRoute != '/appointments'){
                Navigator.of(context).pushNamed('/appointments');
              }
            },
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: 60,
              child:  Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.calendar_month),
                  ),
                  Text('Meetings')
                ],
              ),
            ),
          ),
        ),
        //КНОПКА КОНТАКТЫ
        Material(
          color: ifActiveContactsButton(),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          child: InkWell(
            onTap: (){
              if(itRoute != '/time_manager'){
                Navigator.of(context).pushNamed('/time_manager');
              }
            },
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: 60,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.timer_sharp),
                  ),
                  Text('Time_manager')
                ],
              ),
            ),
          ),
        ),
        //КНОПКА заметки
        Material(
          color: ifActiveTasksButton(),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          child: InkWell(
            onTap: (){
              if(itRoute != '/'){
                Navigator.of(context).pushNamed('/');
              }

            },
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: 60,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.add_task_outlined),
                  ),
                  Text('Tasks'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
