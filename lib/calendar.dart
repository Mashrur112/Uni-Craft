import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uni_craft/Stopwatch.dart';
import 'package:uni_craft/timeplanner.dart';
import 'package:http/http.dart' as http;

import 'notification.dart';

class Calendar extends StatefulWidget {
  var uid_ad,role;
  Calendar(this.uid_ad, this.role,{Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.timestamp();
  Map<DateTime, List<String>> events = {};
  Map<String, dynamic> e = {};
  List token = [];

  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      today = day;
    });
  }

  void _onEventAdded(String event) {
    setState(() {
      events.update(
        today,
        (existingEvents) => [...existingEvents, event],
        ifAbsent: () => [event],
      );
      e.update(
        today.toString(),
        (existingEvents) => [...existingEvents, event],
        ifAbsent: () => [event],
      );

      FirebaseFirestore.instance
          .collection("Profile")
          .doc(widget.uid_ad)
          .update({
        "events": e,
      });
    });
  }

  void _deleteEvent(String event) {
    setState(() {
      if (events.containsKey(today)) {
        events[today]!.remove(event);

        if (events[today]!.isEmpty) {
          events.remove(today);
        }
      }
      print(today.toString());
      e.remove(today.toString());
      FirebaseFirestore.instance
          .collection("Profile")
          .doc(widget.uid_ad)
          .update({
        "events": e,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Calendar"),
        backgroundColor: Color(0xff7a9e9f), //Colors.black.withOpacity(0.35),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.calendar_view_week),
          //   onPressed: () {
          //     // Navigate to the TimePlanner page
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             TimePlannerPage(), // Replace with your TimePlanner page widget
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Profile").snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  token.clear();
                  var join_code;
                  var res = snapshots.data!.docs.toList();
                  for (var r in res) {
                    if (r['uid'] == widget.uid_ad) {
                      join_code=r['code'];
                      try {
                        e = r['events'];

                       // print(e);
                      } catch (e) {}
                      ;

                      ;
                    }
                  }
                  for(var r in res)
                    {
                      if(r['code']==join_code && r['role']!="Administrator")
                        {
                          token.add(r['token']);
                        }
                    }
                }
                return Center();
              }),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/calendar_bg04.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                      0.75), // Adjust the opacity here (0.0 to 1.0)
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                        "Selected Day = ${today.toString().split(" ")[0]}"),
                  ),
                  TableCalendar(
                    locale: "en_US",
                    rowHeight: 43,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    focusedDay: today,
                    firstDay: DateTime.utc(2012, 01, 01),
                    lastDay: DateTime.utc(2050, 01, 01),
                    onDaySelected: _onDaySelected,
                  ),
                  const SizedBox(height: 20),
                  TodoListView(
                    role: widget.role,
                    to: token,
                    uid: widget.uid_ad,
                    selectedDate: today,
                    events: events[today] ?? [],
                    onEventAdded: _onEventAdded,
                    onDeleteEvent: _deleteEvent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xffb8d8d8),
    );
  }
}

class TodoListView extends StatefulWidget {
  final DateTime selectedDate;
  List events = [];
  final Function(String) onEventAdded;
  final Function(String) onDeleteEvent;
  var uid,to;
  var role;

  TodoListView({
    required this.selectedDate,
    required this.events,
    required this.onEventAdded,
    required this.onDeleteEvent,
    required this.uid,
    required this.to,
    required this.role,
    Key? key,
  }) : super(key: key);

  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Events for ${widget.selectedDate.toString().split(" ")[0]}",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Profile").snapshots(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                var res = snapshots.data!.docs.toList();
                for (var r in res) {
                  if (r['uid'] == widget.uid) {
                    try {
                      widget.events =
                          r['events'][widget.selectedDate.toString()];
                    } catch (e) {}
                    ;
                  }
                }
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: widget.events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.events[index]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red.withOpacity(0.7),
                      ),
                      onPressed: () {
                        setState(() {

                        });
                        widget.onDeleteEvent(widget.events[index]);
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            }),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Add your new Event.........",
                    hintStyle: TextStyle(
                        color: Colors.blueGrey), // Color of the hint text
                    // Optionally, you can set the border color and focused border color
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(
                      color: Colors.black), // Color of the entered text
                ),
              ),
              widget.role=="Administrator"?
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black.withOpacity(0.9),
                ),
                onPressed: () {
                  final newEvent = textController.text;
                  print(widget.events);
                  setState(() {});
                  if (newEvent.isNotEmpty) {
                    PushNotifications.init().then((value)async{
                      final token= await FirebaseMessaging.instance.getToken();
                      print(token);
                      for(int i=0;i<widget.to.length;i++){
                        var data={
                          'to':widget.to[i],
                          'priority':'high',
                          'notification':{
                            'title':"New Event",
                            'body':newEvent.toString(),
                          },
                          'additional option':{
                            'channel':'1',
                          }

                        };
                        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                            body:jsonEncode(data) ,
                            headers: {
                              'Content-Type':'application/json; charset=UTF-8',
                              'Authorization':'key=AAAA2TCZdvQ:APA91bHvIxfRdJ4yoEJXHDrPKBcMeWmf-VlVcHuh6gvun7QUGwrFiN9dobcO7H8jx1Z7ayt3nXEV2yjnoWB3_VbdranUUy8UNRfuEDOtb9vCWqi-DXxmZk-1Bnul2UfUnX1zhi-pm9vH'
                            }
                        );}


                    });
                    widget.onEventAdded(newEvent);
                    textController.clear();
                  }
                },
              ):Center(),
            ],
          ),
        ),
      ],
    );
  }
}
