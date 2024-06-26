import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'notification.dart';

class CreatePoll extends StatefulWidget {
  var uid_admin;
  CreatePoll(this.uid_admin);
  @override
  _CreatePollState createState() => _CreatePollState();
}

class _CreatePollState extends State<CreatePoll> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();

  List<String> options = [];
  List<String> poll_id = [];

  @override
  void dispose() {
    _captionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    super.dispose();
  }

  List to = [];

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xffb8d8d8),
        appBar: AppBar(
          title: Text('Create Poll'),
          backgroundColor: Color(0xff7a9e9f),
        ),
        body: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection("Profile").snapshots(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                var code;
                //print("fsd");
                var res = snapshots.data!.docs.toList();
                to.clear();
                for (var r in res) {
                  if (r['uid'] == FirebaseAuth.instance.currentUser!.uid)
                    code = r['code'];
                }

                for (var r in res) {
                  if (r['code'] == code.toString() &&
                      r['role'] != "Administrator") {
                    // print(r['name1']+widget.code);
                    try {
                      to.add(r['token']);
                    } catch (e) {}
                    ;
                  }
                }
                //print(to);
              }
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                      ),
                      Text(
                        'Caption:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _captionController,
                        decoration: InputDecoration(
                          hintText: 'Enter poll caption',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Options:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      _buildOptionTextField(_option1Controller, 'Option 1'),
                      SizedBox(height: 10),
                      _buildOptionTextField(_option2Controller, 'Option 2'),
                      SizedBox(height: 10),
                      _buildOptionTextField(_option3Controller, 'Option 3'),
                      SizedBox(height: 50),
                      Center(
                        child: Container(
                          height: 0.05 * screenH,
                          width: 0.3 * screenW,
                          decoration: BoxDecoration(
                            color: Color(0xff33678a),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                options.clear();
                                if (_option1Controller.text.isNotEmpty) {
                                  options.add(_option1Controller.text);
                                }
                                if (_option2Controller.text.isNotEmpty) {
                                  options.add(_option2Controller.text);
                                }
                                if (_option3Controller.text.isNotEmpty) {
                                  options.add(_option3Controller.text);
                                }
                              });
                              _createPoll();
                            },
                            child: Center(
                                child: const Text(
                                  "Create Poll",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  Widget _buildOptionTextField(
      TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _createPoll() {
    Navigator.pop(context);
    PushNotifications.init().then((value) async {
      final token = await FirebaseMessaging.instance.getToken();
      print(token);
      for (int i = 0; i < to.length; i++) {
        var data = {
          'to': to[i],
          'priority': 'high',
          'notification': {
            'title': "New Poll",
            'body': _captionController.text.toString(),
          },
          'additional option': {
            'channel': '1',
          }
        };
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':
              'key=AAAA2TCZdvQ:APA91bHvIxfRdJ4yoEJXHDrPKBcMeWmf-VlVcHuh6gvun7QUGwrFiN9dobcO7H8jx1Z7ayt3nXEV2yjnoWB3_VbdranUUy8UNRfuEDOtb9vCWqi-DXxmZk-1Bnul2UfUnX1zhi-pm9vH'
            });
      }
    });
    String caption = _captionController.text;
    if (caption.isEmpty || options.length < 2) {
      _showErrorDialog();
    } else {
      // Initialize Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Collection reference
      CollectionReference polls = firestore.collection('Profile');

      // Create a document with an auto-generated ID
      polls.doc(widget.uid_admin).update({
        'caption': caption,
        'options': options,
        'votes': List.filled(options.length, '0'),
        'poll_id': List.filled(0, '0'),
      }).then((value) {
        // Successfully added to Firestore
        print('Poll created with ID: ${widget.uid_admin}');

        // Here, you can navigate to the poll view page or perform other actions
      }).catchError((error) {
        // Error handling
        print('Failed to create poll: $error');
      });
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a caption and at least 2 options.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}