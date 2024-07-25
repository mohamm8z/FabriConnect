import 'package:FabriConnect/chat_screen.dart';
import 'package:FabriConnect/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget{
  const MessageScreen({Key?key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: "My Messages".text.color(Colors.black).make(),
        ),
        body:StreamBuilder(
        stream:FirestoreServices.getAllMessages(),
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
    if(!snapshot.hasData){
    return Center(
             child:  CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
           );
    }
    else if(snapshot.data!.docs.isEmpty){
          return Center(child: "No Messages yet!".text.color(Colors.black).make());
    }
    else
    {
      var data=snapshot.data!.docs;
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              children: [
                Expanded(child: ListView.builder(
                    itemCount:data.length ,
                    itemBuilder: (BuildContext context,int index){
                      return Card(
                        child: ListTile(
                          onTap: (){
                            Get.to(()=>ChatScreen(),
                              arguments: [data[index]['friend_name'],data[index]['toId'],data[index]['sender_name']],
                            );

                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.person,color: Colors.white,),
                          ),
                          title: "${data[index]['friend_name']}".text.color(Colors.black).make(),
                          subtitle: "${data[index]['last_msg']}".text.make(),
                        ),
                      );
                    }),
                )
              ],
          ),
            );
    }
    }

  ) ,
  );
}
}