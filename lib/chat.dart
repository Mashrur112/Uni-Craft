import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uni_craft/auth-page.dart';
import 'package:uni_craft/dependency_injection.dart';
import 'package:uni_craft/splash.dart';
import 'dashboard.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';


class ChatApp extends StatefulWidget {
  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  List<MessageModel> messages = [];
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.blueGrey.withOpacity(0.9),
          title: Center(
            child: Text(
              'General Chat',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatMessageWidget(message: messages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.9,
                          horizontal: 15.0,
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _sendMessage(messageController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String messageText) {
    User currentUser =
    User(name: 'Your Name', profilePic: 'assets/images/profile.png');
    MessageModel newMessage = MessageModel(
      text: messageText,
      time: DateTime.now().toString(),
      user: currentUser,
    );

    setState(() {
      messages.add(newMessage);
    });

    messageController.clear();
  }
}

class ChatMessageWidget extends StatelessWidget {
  final MessageModel message;

  ChatMessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 17.5,
                backgroundImage: AssetImage(
                  message.user.profilePic,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                maxWidth: 290,
              ),
              child: Material(
                color: const Color(0xFFADD8E6),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            message.user.name,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: (13 / 8.12) * 8,
                              color: const Color(0xd9343f4b),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(width: 8),
                          Text(
                            message.time,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 11,
                              color: const Color(0xFF000000),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            color: const Color(0xFF000000),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      _isPhoto(message),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _isPhoto(MessageModel message) {
    if (message.imageUrl != null && message.imageUrl.isNotEmpty) {
      return Image.network(
        message.imageUrl,
        height: 100,
        width: 100,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

class User {
  final String name;
  final String profilePic;

  User({
    required this.name,
    required this.profilePic,
  });
}

class MessageModel {
  final String text;
  final String time;
  final User user;
  final String imageUrl;

  MessageModel({
    required this.text,
    required this.time,
    required this.user,
    this.imageUrl = '',
  });
}


