import 'package:get/get.dart';
import 'package:rightchat_app/screen/profile/model/profile_model.dart';
import 'package:rightchat_app/utils/helper/db_helper.dart';

class LoginController extends GetxController {
  ProfileModel? profileModel;

  Future<void> getProfileData() async {
    profileModel = await FireDbHelper.helper.getSignInProfile();
  }
}
