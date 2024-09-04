import 'package:get/get.dart';
import 'package:rightchat_app/screen/profile/model/profile_model.dart';
import 'package:rightchat_app/utils/helper/db_helper.dart';

class UserController extends GetxController {
  RxList<ProfileModel> userList = <ProfileModel>[].obs;

  void getUsers() async {
    userList.value = await FireDbHelper.helper.getAllUsers();
  }
}
