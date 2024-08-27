import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rightchat_app/screen/profile/model/profile_model.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //insert/Update User(Profile) Data
  void setProfile(ProfileModel profileModel) async {
    await fireStore.collection("User").doc(AuthHelper.helper.user!.uid).set({
      "name": profileModel.name,
      "mobile": profileModel.mobile,
      "email": profileModel.email,
      "bio": profileModel.bio
    });
  }
}
