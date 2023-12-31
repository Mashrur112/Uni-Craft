import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimePlannerPage extends StatefulWidget {
  @override
  _TimePlannerPageState createState() => _TimePlannerPageState();
}

class _TimePlannerPageState extends State<TimePlannerPage> {
  List<Meeting> meetings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Planner"),
        backgroundColor: Colors.black.withOpacity(0.35),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _showAddMeetingDialog(context);
            },
            child: Text("Add Meeting"),
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.week,
              dataSource: MeetingDataSource(meetings),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddMeetingDialog(BuildContext context) async {
    TextEditingController eventNameController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedStartTime = TimeOfDay.now();
    TimeOfDay selectedEndTime = TimeOfDay.now();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Meeting'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: eventNameController,
                decoration: InputDecoration(labelText: 'Event Name'),
              ),
              SizedBox(height: 10),
              Text('Select Date:'),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(
                  'Choose Date',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Text('Select Time Range:'),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? pickedStartTime = await showTimePicker(
                    context: context,
                    initialTime: selectedStartTime,
                  );
                  if (pickedStartTime != null &&
                      pickedStartTime != selectedStartTime) {
                    setState(() {
                      selectedStartTime = pickedStartTime;
                    });
                  }
                },
                child: Text(
                  'Choose Start Time',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? pickedEndTime = await showTimePicker(
                    context: context,
                    initialTime: selectedEndTime,
                  );
                  if (pickedEndTime != null &&
                      pickedEndTime != selectedEndTime) {
                    setState(() {
                      selectedEndTime = pickedEndTime;
                    });
                  }
                },
                child: Text(
                  'Choose End Time',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  meetings.add(
                    Meeting(
                      eventNameController.text,
                      DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedStartTime.hour,
                        selectedStartTime.minute,
                      ),
                      DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedEndTime.hour,
                        selectedEndTime.minute,
                      ),
                      const Color(0xFF0F8644),
                      false,
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  // Implement the remaining methods from your MeetingDataSource class
  // ...

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
