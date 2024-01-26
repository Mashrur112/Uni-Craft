import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/message.dart';


class MessageService{
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String buildChatRoomID(String senderID, String receiverID){
    List<String> id = [senderID, receiverID];
    id.sort();
    String chatRoomID = id.join("_");
    return chatRoomID;
  }

  // Send Message
  Future sendMessage(String receiverID, String receiverEmail, String message) async {
    // Current User Info
    String senderID = _auth.currentUser!.uid;
    String senderEmail = _auth.currentUser!.email.toString();
    Timestamp timestamp = Timestamp.now();

    //   Create chat room with id as - senderID_receiverID
    String chatRoomID = buildChatRoomID(senderID, receiverID);

    // create message document inside chat_room
    final docMessage = _firestore.collection("chat_room").doc(chatRoomID).collection("messages").doc();

    //   Create new message
    Message newMessage = Message(
        mid: docMessage.id,
        senderID: senderID,
        senderEmail: senderEmail,
        receiverID: receiverID,
        receiverEmail: receiverEmail,
        message: message,
        timeSent: timestamp,
        messageSeen: false,
        timeSeen: null
    );

    //   Store the message in Cloud Firestore
    await docMessage.set(newMessage.toJson());

  }

//   Map snapshot into a list of message object
  List<Message> messageListFromSnapshot(QuerySnapshot snapshot){
    final messageList = snapshot.docs.map(
            (doc) => Message(
          mid: doc.get("mid"),
          senderID: doc.get("senderID"),
          senderEmail: doc.get("senderEmail"),
          receiverID: doc.get("receiverID"),
          receiverEmail: doc.get("receiverEmail"),
          message: doc.get("message"),
          timeSent: doc.get("timeSent"),
          messageSeen: doc.get("messageSeen"),
          timeSeen: doc.get("timeSeen"),
        )
    ).toList();

    return messageList;
  }


//   Get Messages from chat_room collection
  Stream<List<Message>> getMessages(String senderID, String receiverID) {
    // Get the chat room id
    String chatRoomID = buildChatRoomID(senderID, receiverID);
    //   Get the message from firestore
    return _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy('timeSent', descending: true)
        .snapshots()
        .map(messageListFromSnapshot);
  }


  Future updateSeenStatus(Message message,String senderID, String receiverID) async{
    Timestamp timestamp = Timestamp.now();
    // Get the chat room id
    String chatRoomID = buildChatRoomID(senderID, receiverID);

    //   get the message by message ID
    final docMessage = _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("messages")
        .doc(message.mid);

    if (message.receiverID == _auth.currentUser!.uid){
      await docMessage.set({
        "messageSeen": true,
        "timeSeen": timestamp
      }, SetOptions(merge: true));
    }
  }

  Stream<List<Message>> getUnseenMessages(String senderID, String receiverID){
    // Get the chat room id
    String chatRoomID = buildChatRoomID(senderID, receiverID);

    // get all messages where senderID == receiverID && messageSeen == false
    return _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("messages")
        .where("receiverID", isEqualTo: senderID)
        .where("messageSeen", isEqualTo: false)
        .snapshots()
        .map(messageListFromSnapshot);
  }
}