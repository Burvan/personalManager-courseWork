import 'package:flutter/material.dart';

import 'package:my_course_work/screens/appointments/event.dart';
import 'package:my_course_work/screens/appointments/event_provider.dart';
import 'package:provider/provider.dart';
import 'utils.dart';


class EventEditingPage extends StatefulWidget {
  const EventEditingPage({Key? key, this.event}) : super(key: key);

  final Event? event;

  /*const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);*/

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.event == null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEditingActions(),
        backgroundColor: Colors.indigo[400],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              TextFormField(
                style: TextStyle(fontSize: 24),
                onFieldSubmitted: (_) => saveForm(),
                controller: titleController,
                validator: (title)=> title != null && title.isEmpty ? 'Заголовок не может быть пустым' : null,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Add title',
                ),
              ),
              SizedBox(height: 12),
              buildDateTimePickers(),
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> buildEditingActions() => [
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: saveForm,
      icon: Icon(Icons.done),
      label: Text('Save'),
    )
  ];
  Widget buildDateTimePickers(){
    return Column(
        children: [
           buildFrom(),
           buildTo(),
        ],
    );
  }
  Widget buildFrom(){
    return buildHeader(
      header: 'FROM',
      child: Row(
        children: [
          Expanded(
            flex: 2,
              child: buildDropdownField(
                  text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              )
          ),
          Expanded(
              child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              )
          ),
        ],
      ),
    );
  }
  Widget buildTo(){
    return buildHeader(
      header: 'To',
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              )
          ),
          Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              )
          ),
        ],
      ),
    );
  }
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate)){
      toDate = DateTime(
        date.year, date.month, date.day, toDate.hour, toDate.minute
      );
    }
    setState(() {
      fromDate = date;
    });
  }
  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null
    );
    if (date == null) return;
    if (date.isBefore(fromDate)){
      toDate = DateTime(
          date.year, date.month, date.day, toDate.hour, toDate.minute
      );
    }
    setState(() {
      toDate = date;
    });
  }
  Future<DateTime?> pickDateTime(
      DateTime initialDate, {
        required bool pickDate,
        DateTime? firstDate,
  }) async{
    if (pickDate){
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2019, 8),
        lastDate: DateTime(2101),
      );
      if (date == null) return null;
      final time = Duration(
          hours: initialDate.hour,
          minutes: initialDate.minute
      );
      return date.add(time);

    }
    else {
      final timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate)
      );

      if(timeOfDay == null) return null;
      final date = DateTime(
          initialDate.year,
          initialDate.month,
          initialDate.day
      );
      final time = Duration(
          hours: timeOfDay.hour,
          minutes: timeOfDay.minute
      );
      return date.add(time);
    }
  }
  Widget buildDropdownField({required String text, required VoidCallback onClicked}) => ListTile(
    title: Text(text),
    trailing: Icon(Icons.arrow_drop_down_outlined),
    onTap: onClicked,
  );

  Widget buildHeader({required String header, required Widget child}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header, style: TextStyle(fontWeight: FontWeight.bold)),
      child
    ],
  );
  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid){
      final event = Event(
        title: titleController.text,
        description: 'Description',
        from: fromDate,
        to: toDate,
        isAllDay: false
      );
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);
      Navigator.of(context).pop();
    }
  }


}


