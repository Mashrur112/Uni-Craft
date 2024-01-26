import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String? mid;
  String? senderID;
  String? senderEmail;
  String? receiverID;
  String? receiverEmail;
  String? message;
  Timestamp? timeSent;
  bool? messageSeen;
  Timestamp? timeSeen;

  Message({this.mid, this.senderID, this.senderEmail, this.receiverID, this.receiverEmail,
    this.message, this.timeSent, this.messageSeen, this.timeSeen});

  Map<String, dynamic> toJson() => {
    'mid': mid,
    'senderID': senderID,
    'senderEmail': senderEmail,
    'receiverID': receiverID,
    'receiverEmail': receiverEmail,
    'message': message,
    'timeSent': timeSent,
    'messageSeen': messageSeen,
    'timeSeen': timeSeen
  };

}