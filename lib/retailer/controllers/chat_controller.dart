import 'package:FabriConnect/firebase_consts.dart';
import 'package:FabriConnect/retailer/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  @override
  void onInit(){
    getChatId();
    super.onInit();
  }
  var isLoading=false.obs;
  var Chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.arguments[2];

  var currentId = FirebaseAuth.instance.currentUser!.uid;

  var msgController = TextEditingController();
  dynamic chatDocId;

  getChatId() async {

    isLoading(true);

    await Chats.where('users',isEqualTo: {
      friendId:null,
      currentId:null
    }
    ).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocId=snapshot.docs.single.id;
      }
      else{
        Chats.add({
          'created_on':null,
          'last_msg':'',
          'users':{friendId:null,currentId:null},
          'toId':'',
          'fromid':'',
          'friend_name':friendName,
          'sender_name':senderName,
        }).then((value) {
          chatDocId=value.id;
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg) async{
    if(msg.trim().isNotEmpty){
      Chats.doc(chatDocId).update({
        'created_on':FieldValue.serverTimestamp(),
        'last_msg':msg,
        'toId':friendId,
        'fromid':currentId,
      });

      Chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on':FieldValue.serverTimestamp(),
        'msg':msg,
        'uid':currentId,
      });
    }
  }

}