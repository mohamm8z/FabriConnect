import 'package:b2b/firebase_consts.dart';
import 'package:b2b/firestore_services.dart';
import 'package:b2b/item_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget{
  const WishlistScreen({Key?key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: "My Wishlist".text.color(Colors.black).make(),
        ),
        body:StreamBuilder(
        stream:FirestoreServices.getWishlists(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
              return Center(
             child:  CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
           );
          }
         else if(snapshot.data!.docs.isEmpty){
            return Center(child: "No items yet!".text.color(Colors.black).make());
          }
          else
          {
          var data=snapshot.data!.docs;
          return Column(
            children: [
              Expanded(
              child: ListView.builder(
              shrinkWrap: true,
               itemCount: data.length,
               itemBuilder: (BuildContext context,int index){
                 return ListTile(
                   leading: InkWell(
                       onTap:(){
                         Get.to(item_detail(
                             "${data[index]['p_name']}",
                             data[index]));
                       },
                       child: Image.network("${data[index]['p_imgs'][0]}",width: 80,fit: BoxFit.cover,).box.rounded.clip(Clip.antiAlias).make()),
                   title: "${data[index]['p_name']}".text.size(16).make(),
                   subtitle: "${data[index]['p_price']}".numCurrency.text.color(Colors.red).make(),
                   trailing: Icon(Icons.favorite,color: Colors.red,).onTap(() async {
                     await firestore.collection(productsCollection).doc(data[index].id).set({
                       'p_wishlist':FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
                     },
                     SetOptions(merge:true));
                   }),
                 );
               },
               ),
               ),
            ],
          );
         }
    }
  ) ,
  );
}
}