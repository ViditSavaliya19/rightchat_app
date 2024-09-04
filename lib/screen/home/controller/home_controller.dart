import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/screen/profile/model/profile_model.dart';
import 'package:rightchat_app/utils/helper/db_helper.dart';

class HomeController extends GetxController {
  Stream<QuerySnapshot<Map>>? chatUsers;
  ProfileModel? model;
  RxList<ProfileModel> userList = <ProfileModel>[].obs;

  void getUsers() {
    chatUsers = FireDbHelper.helper.getMyChatUser();
  }
  Future<void> getUIDUsers(receiverId)
  async{
      model = await FireDbHelper.helper.getUIDUsers(receiverId);
  }

}
