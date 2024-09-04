import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel
{
  String? msg,senderID;
  Timestamp? dateTime;
  String? docId;

  ChatModel({this.msg, this.senderID, this.dateTime});

  factory ChatModel.mapToModel(Map m1)
  {
    return ChatModel(
      senderID:m1['sendUID'],
      msg: m1['msg'],
      dateTime: m1['date'],
    );
  }

}