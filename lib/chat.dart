
import 'package:flutter/material.dart';


class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

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
        preferredSize: const Size.fromHeight(50.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.blueGrey.withOpacity(0.9),
          title: const Center(
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
                        borderRadius: const BorderRadius.only(
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
                          style: const TextStyle(color: Colors.white),
                          controller: messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
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

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
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
            const SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(
                maxWidth: 290,
              ),
              child: Material(
                color: const Color(0xFFADD8E6),
                borderRadius: const BorderRadius.only(
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
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            message.user.name,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: (13 / 8.12) * 8,
                              color: Color(0xd9343f4b),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            message.time,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 11,
                              color: Color(0xFF000000),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          message.text,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 10),
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
    if (message.imageUrl.isNotEmpty) {
      return Image.network(
        message.imageUrl,
        height: 100,
        width: 100,
      );
    } else {
      return const SizedBox.shrink();
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


