import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rightchat_app/screen/chat/controller/chat_controller.dart';
import 'package:rightchat_app/screen/chat/model/chat_model.dart';
import 'package:rightchat_app/screen/profile/model/profile_model.dart';
import 'package:rightchat_app/utils/helper/auth_helper.dart';
import 'package:rightchat_app/utils/helper/db_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ProfileModel model = Get.arguments;
  TextEditingController txtSend = TextEditingController();
  ChatController controller = Get.put(ChatController());

  @override
  void initState() {
    controller.getChatData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: CircleAvatar(
            child: Text(model.name![0]),
          ),
        ),
        title: Text("${model.name}"),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: controller.dataSnap,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                List<ChatModel> chatList = [];
                QuerySnapshot? snap = snapshot.data;
                for (var x in snap!.docs) {
                  Map m1 = x.data() as Map;
                  ChatModel c1 = ChatModel.mapToModel(m1);
                  c1.docId = x.id;
                  chatList.add(c1);
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.all(5),
                        height: 50,
                        alignment: chatList[index].senderID !=
                                AuthHelper.helper.user!.uid
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: InkWell(
                          onLongPress: () {
                            if (chatList[index].senderID ==
                                AuthHelper.helper.user!.uid) {
                              Get.defaultDialog(
                                  title: "Delete This Message",
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          await FireDbHelper.helper
                                              .deleteMessage(
                                                  chatList[index].docId!);
                                          Get.back();
                                        },
                                        child: const Text("Delete")),
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text("Cancel"))
                                  ]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.sizeOf(context).width * 0.50,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("${chatList[index].msg}"),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtSend,
                      decoration:
                          const InputDecoration(hintText: "Write Message"),
                    ),
                  ),
                  IconButton.filledTonal(
                      onPressed: () {
                        ChatModel chatModel = ChatModel(
                          dateTime: Timestamp.now(),
                          msg: txtSend.text,
                          senderID: AuthHelper.helper.user!.uid,
                        );

                        FireDbHelper.helper.sendMessage(
                            AuthHelper.helper.user!.uid, model.uid!, chatModel);
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
