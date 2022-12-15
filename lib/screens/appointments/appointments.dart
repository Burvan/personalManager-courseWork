import 'package:flutter/material.dart';
import 'package:my_course_work/BottomBar/bottom_bar.dart';
import 'package:my_course_work/screens/appointments/event_data_source.dart';
import 'package:my_course_work/screens/appointments/event_editing_page.dart';
import 'package:my_course_work/screens/appointments/event_provider.dart';
import 'package:my_course_work/screens/appointments/meetings_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Appointments extends StatelessWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(
        title: Text('Have a good day', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo[300],
      ),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: EventDataSource(events),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          onLongPress: (details){
            final provider = Provider.of<EventProvider>(context, listen: false);
            provider.setDate(details.date!);
            showModalBottomSheet(
                context: context,
                builder: (context) => MeetingWidget(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_box_rounded, color: Colors.white),
          backgroundColor: Colors.indigo[300],
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EventEditingPage()),
            );
          },
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}


