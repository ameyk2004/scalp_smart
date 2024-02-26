import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final Timestamp timestamp;
  final String message;

  Message(
      {required this.senderId,
      required this.senderEmail,
      required this.recieverId,
      required this.timestamp,
      required this.message});

  Map<String,dynamic> toMap()
  {
    return
        {
          "senderId" : senderId,
          "senderEmail" :senderEmail,
          "recieverId" : recieverId,
          "timestamp" : timestamp,
          "message" : message,
        };
  }
}
