import 'package:flutter/material.dart';
import 'package:my_course_work/screens/appointments/event_data_source.dart';
import 'package:my_course_work/screens/appointments/event_provider.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingWidget extends StatefulWidget {
  const MeetingWidget({Key? key}) : super(key: key);

  @override
  State<MeetingWidget> createState() => _MeetingWidgetState();
}

class _MeetingWidgetState extends State<MeetingWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: Text(
            'Не найдено запланированных событий',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      );
    }
    return SfCalendarTheme(
        data: SfCalendarThemeData(
            timeTextStyle: TextStyle(fontSize: 16, color: Colors.black)),
        child: SfCalendar(
          view: CalendarView.timelineDay,
          dataSource: EventDataSource(provider.events),
          initialDisplayDate: provider.selectedDate,
          appointmentBuilder: appointmentBuilder,
          headerHeight: 0,
          todayHighlightColor: Colors.black,
          selectionDecoration: BoxDecoration(
            color: Colors.red.withOpacity(0.3),
          ),
          onTap: (details) {
            //if(details.appointments == null) return;
            //final event = details.appointments!.first;

            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => EventViewingPage(event: event),
            // ));
          },
        ));
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
