import 'package:FabriConnect/constants/colors.dart';
import 'package:FabriConnect/firestore_services.dart';
import 'package:FabriConnect/retailer/controllers/chat_controller.dart';
import 'package:FabriConnect/sender_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget{
  const ChatScreen({Key?key}):super(key:key);

  @override
  Widget build(BuildContext context){

    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "${controller.friendName}".text.color(Colors.black).make(),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child:Column(
          children: [
            Obx(() =>
              controller.isLoading.value? Center(
                 child:  CircularProgressIndicator(
                         valueColor: AlwaysStoppedAnimation(Colors.red),
                 ),
                ): Expanded(child: StreamBuilder(
                  stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                   if(!snapshot.hasData){
                     return Center(
                       child:  CircularProgressIndicator(
                         valueColor: AlwaysStoppedAnimation(Colors.red),
                       ),
                     );
                   }
                   else if(snapshot.data!.docs.isEmpty){
                     return Center(
                       child: "send a message".text.color(Colors.black).make(),
                     );
                   }
                   else
                   {
                     return ListView(
                       children: snapshot.data!.docs.mapIndexed((currentValue, index){
                         var data=snapshot.data!.docs[index];
                         return Align(
                             alignment: data['uid']==FirebaseAuth.instance.currentUser!.uid?Alignment.centerRight:Alignment.centerLeft,
                             child: senderBubble(data));
                       }).toList(),
                     );
                   }
              }
              )),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.msgController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    hintText: "Type a message...",
                  ),
                )),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                }, icon: Icon(Icons.send,color: Colors.red,)),
              ],
            ).box.height(80).padding(EdgeInsets.all(12)).margin(EdgeInsets.only(bottom: 8)).make()
          ],
        )
      )
    );
  }
}