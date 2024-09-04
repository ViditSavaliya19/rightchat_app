import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rightchat_app/screen/chat/model/chat_model.dart';
import 'package:rightchat_app/screen/profile/model/profile_model.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String? docId;

  //insert/Update User(Profile) Data
  Future<void> setProfile(ProfileModel profileModel) async {
    await fireStore.collection("User").doc(AuthHelper.helper.user!.uid).set({
      "name": profileModel.name,
      "mobile": profileModel.mobile,
      "email": profileModel.email,
      "bio": profileModel.bio,
      "uid": AuthHelper.helper.user!.uid
    });
  }

  //get Login User Data
  Future<ProfileModel?> getSignInProfile() async {
    DocumentSnapshot docData = await fireStore
        .collection("User")
        .doc(AuthHelper.helper.user!.uid)
        .get();

    if (docData.exists) {
      Map m1 = docData.data() as Map;
      ProfileModel model = ProfileModel.mapToModel(m1);
      return model;
    } else {
      return null;
    }
  }

  //Get All User exclude me
  Future<List<ProfileModel>> getAllUsers() async {
    List<ProfileModel> profileList = [];

    QuerySnapshot snapshot = await fireStore
        .collection("User")
        .where("uid", isNotEqualTo: AuthHelper.helper.user!.uid)
        .get();

    List<QueryDocumentSnapshot> docList = snapshot.docs;

    for (var x in docList) {
      Map m1 = x.data() as Map;
      String docId = x.id;
      ProfileModel model = ProfileModel.mapToModel(m1);
      model.uid = docId;
      profileList.add(model);
    }

    return profileList;
  }

  //sendMessage
  void sendMessage(
      String senderUID, String receiverUID, ChatModel model) async {
    //Database check as per both uids
    String? docId = await checkChatConversationDoc(senderUID, receiverUID);

    if (docId == null) {
      //create new chat
      DocumentReference reference = await fireStore.collection("Chat").add({
        "uids": [senderUID, receiverUID]
      });
      docId = reference.id;
    }

    //send Message
    await fireStore.collection("Chat").doc(docId).collection("msg").add({
      "msg": model.msg,
      "sendUID": model.senderID,
      "date": model.dateTime,
    });
  }

  Future<String?> checkChatConversationDoc(
      String senderUID, String receiverUID) async {
    //s - h  => h-s
    QuerySnapshot snapshot = await fireStore
        .collection("Chat")
        .where("uids", isEqualTo: [senderUID, receiverUID]).get();
    List<DocumentSnapshot> docList = snapshot.docs;

    print("================= ${docList.length}");

    if (docList.isEmpty) {
      QuerySnapshot snapshot1 = await fireStore
          .collection("Chat")
          .where("uids", isEqualTo: [receiverUID, senderUID]).get();

      List<DocumentSnapshot> l2 = snapshot1.docs;

      if (l2.isEmpty) {
        return null;
      } else {
        DocumentSnapshot ds2 = l2[0];
        return ds2.id;
      }
    } else {
      DocumentSnapshot sp = docList[0];
      return sp.id;
    }
  }

  Future<void> getChatDocID(String senderUID, String receiverUID) async {
    docId = await checkChatConversationDoc(senderUID, receiverUID);
  }

  //show Chat history
  Stream<QuerySnapshot<Map>> readChat() {
    Stream<QuerySnapshot<Map>> streamData = fireStore
        .collection("Chat")
        .doc(docId)
        .collection("msg")
        .orderBy("date", descending: false)
        .snapshots();
    return streamData;
  }

  Future<void> deleteMessage(String msgDocID) async {
    await fireStore
        .collection("Chat")
        .doc(docId)
        .collection("msg")
        .doc(msgDocID)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyChatUser() {
    return fireStore
        .collection("Chat")
        .where("uids", arrayContains: AuthHelper.helper.user!.uid)
        .snapshots();
  }
  
  
  Future<ProfileModel> getUIDUsers(receiverUID) async {
    DocumentSnapshot snapshot = await fireStore.collection("User").doc(receiverUID).get();
    Map m1 = snapshot.data() as Map;
    ProfileModel profileModel =ProfileModel.mapToModel(m1);
    return profileModel;
  }
  
  
  
}
