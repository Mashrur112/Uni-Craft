import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uni_craft/chat/service/messageService.dart';

import '../notification.dart';
import 'model/message.dart';

class MessagePage extends StatefulWidget {
  String receiverID;
  String receiverEmail;
  MessagePage({required this.receiverID, required this.receiverEmail});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  var messageController = TextEditingController();
  final MessageService messageService = MessageService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  var token;

  Widget textMessgaeForm() {
    return Form(
        key: formKey,
        child: Row(
          children: [
            Expanded(
                flex: 7,
                child: TextFormField(
                  controller: messageController,
                  onTapOutside: (PointerDownEvent event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Text"
                  ),
                )),
            StreamBuilder(stream: FirebaseFirestore.instance.collection("Profile").snapshots(), builder: (context,snapshots){
              if(snapshots.hasData)
                {
                  var res =snapshots.data!.docs.toList();
                  for(var r in res)
                    {
                      if(r['uid']==widget.receiverID.toString())
                        {
                          token =r['token'];
                        }
                    }
                }

              return Center();
            }),
            Expanded(
                flex: 1,
                child: IconButton(onPressed: () async{
                  PushNotifications.init().then((value)async{

                    print(token);

                      var data={
                        'to':token.toString(),
                        'priority':'high',
                        'notification':{
                          'title':widget.receiverEmail.toString(),
                          'body':messageController.text.toString(),
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
                      );


                  });
                  if(messageController.text.isNotEmpty){
                    await messageService.sendMessage(widget.receiverID, widget.receiverEmail, messageController.text);
                    messageController.clear();
                  }
                }, icon: Icon(Icons.send)))
          ],
        ));
  }

  Widget chatBox(String message, chatBoxColor){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:chatBoxColor
      ),
      child: Text(message, style: TextStyle(fontSize: 18),),
    );
  }

  // Builds a messageItem with sender email, chatbox,
  // time info of when message sent and when seen
  Widget messageItem(Message message) {
    String messageSent = DateFormat('MMMM d, yyyy HH:mm').format(message.timeSent!.toDate());
    var alignment, crossAxisAlignment, chatBoxColor, seenStatus, seenColor;

    if (message.receiverID == _auth.currentUser!.uid && message.messageSeen != true){
      messageService.updateSeenStatus(message, _auth.currentUser!.uid, widget.receiverID);
    }

    if(message.senderID == _auth.currentUser!.uid){
      //   current user sent the messages. so his sent messages should be on the right
      alignment = Alignment.centerRight;
      crossAxisAlignment = CrossAxisAlignment.end;
      chatBoxColor = Colors.blue[300];

      if (message.messageSeen == false){
        seenStatus = "unseen";
        seenColor = Colors.red;
      } else {
        seenStatus = "seen at ${DateFormat('MMMM d, yyyy HH:mm').format(message.timeSeen!.toDate())}";
        seenColor = Colors.green;
      }
    } else{
      //   else current user received the message. these messages should be on the left
      alignment = Alignment.centerLeft;
      crossAxisAlignment = CrossAxisAlignment.start;
      chatBoxColor = Colors.grey[300];
      seenStatus = '';
    }

    return Container(
      padding: EdgeInsets.all(5),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text("${message.senderEmail}"),
          chatBox(message.message!, chatBoxColor),
          Text("${messageSent}"),
          Text("${seenStatus}", style: TextStyle(fontSize: 12, color: seenColor),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 20,
              child: StreamBuilder<List<Message>>(
                  stream: messageService.getMessages(_auth.currentUser!.uid, widget.receiverID),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final messageList = snapshot.data;
                      return ListView(
                          reverse: true,
                          children: messageList!.map((message) => messageItem(message)).toList()
                      );
                    } else {
                      return Text("Data Not found");
                    }
                  }
              ),
            ),
            // SizedBox(height: screenHeight*0.7,),
            Divider(
              height: 30,
              color: Colors.black,
              indent: 5,
              endIndent: 5,
              thickness: 0.8,
            ),
            Expanded(flex: 2, child: textMessgaeForm()),
          ],
        ),
      ),
    );
  }
}