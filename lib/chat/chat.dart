import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/chat/service/databaseService.dart';
import 'package:uni_craft/chat/service/messageService.dart';
import 'messagePage.dart';
import 'model/message.dart';
import 'model/user.dart';

class Chat extends StatefulWidget {
  final String uid;
  Chat(this.uid);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Widget showTile(CustomUser user) {
    if (_auth.currentUser!.uid != user.uid) {
      return Card(
        //color: Colors.blue,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.black, width: 2.0),
        ),
        child: Container(
          color: Color(0xff88b5b5),
          height: 59, // Set your desired height (original + 25)
          child: ListTile(
            title: Text(
              "${user.name}",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: StreamBuilder<List<Message>>(
              stream: MessageService().getUnseenMessages(
                _auth.currentUser!.uid,
                user.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final unseenMessageList = snapshot.data;
                  return Text(
                    "${user.email} (${unseenMessageList?.length} unseen messages)",
                  );
                } else {
                  return Text("${user.email}");
                }
              },
            ),
            tileColor: Color(0xff88b5b5),
            splashColor: Colors.black38,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagePage(
                    receiverID: user.uid,
                    receiverEmail: user.email,
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget showUserList() {
    return StreamBuilder<List<CustomUser>>(
      stream: DatabaseService().getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userList = snapshot.data;
          return Column(
            children: userList!.map((user) => showTile(user)).toList(),
          );
        } else {
          return Text("Data Not found");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff77a5b5),
        title: Column(
          children: [

            StreamBuilder<CustomUser>(
              stream: DatabaseService().getUserByUserID(widget.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  CustomUser? customUser = snapshot.data;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chat",
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Text(
                            "${customUser?.name}",
                            style: TextStyle(fontSize: 14,
                            color: Colors.black),
                          ),
                          Text(
                            " (${customUser?.email})",
                            style: TextStyle(fontSize: 13,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Text("Chat");
                }
              },
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();

          },
        ),

      ),
      body: Container(
        color: Color(0xffb8d8d8),
        child: StreamBuilder<CustomUser>(
          stream: DatabaseService().getUserByUserID(widget.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              CustomUser? customUser = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    showUserList(),
                  ],
                ),
              );
            } else {
              return Text("Data Not Found");
            }
          },
        ),
      ),
    );
  }

}
