import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timeslamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.timeslamp,
    required this.message,

});
  //convert to a map
Map<String,dynamic> toMap(){
  return {
    'senderId' : senderId,
    'senderEmail' : senderEmail,
    'receiverId' : receiverId,
    'message' : message,
    'timelamp' : timeslamp,
  };
}
}