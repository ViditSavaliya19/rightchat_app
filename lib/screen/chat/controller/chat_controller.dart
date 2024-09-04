import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/screen/chat/model/chat_model.dart';
import 'package:rightchat_app/utils/helper/db_helper.dart';

class ChatController extends GetxController {
  Stream<QuerySnapshot<Map>>? dataSnap;

  void getChatData() {
     dataSnap =  FireDbHelper.helper.readChat();

  }
}
