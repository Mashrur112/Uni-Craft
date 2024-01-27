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
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(color: Colors.black, width: 2.0),
        ),
        child: Container(
          color: Colors.greenAccent.shade100,
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
            tileColor: Colors.grey[300],
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
        backgroundColor: Colors.blue.shade200,
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
                        style: TextStyle(fontSize: 25),
                      ),
                      Row(
                        children: [
                          Text(
                            "${customUser?.name}",
                            style: TextStyle(fontSize: 18,
                            color: Colors.black),
                          ),
                          Text(
                            " (${customUser?.email})",
                            style: TextStyle(fontSize: 14,
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
      body: StreamBuilder<CustomUser>(
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
                  //SizedBox(height: 40),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await DatabaseService().logoutUser();
                  //   },
                  //   child: Text("Logout"),
                  // ),
                  // SizedBox(height: 30),
                ],
              ),
            );
          } else {
            return Text("Data Not Found");
          }
        },
      ),
    );
  }

}
