import 'package:FabriConnect/firestore_services.dart';
import 'package:FabriConnect/orders_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget{
  const OrdersScreen({Key?key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "My Orders".text.color(Colors.black).make(),
      ),
      body:StreamBuilder(
        stream:FirestoreServices.getAllOrders(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
            child:  CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            );

          }
          else if(snapshot.data!.docs.isEmpty){
            return Center(child: "No Orders yet!".text.color(Colors.black).make());
          }
          else
            {
              var data=snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                  itemBuilder:(BuildContext context,int index){
                  return InkWell(
                    onTap: (){
                      Get.to(OrdersDetails(data: data[index],));
                    },
                    child: ListTile(
                      leading: "${index+1}".text.color(Colors.black).xl.make(),
                      title:data[index]['order_code'].toString().text.color(Colors.red).make(),
                      subtitle: data[index]['total_amount'].toString().numCurrency.text.make(),
                      trailing: IconButton(
                        onPressed: (){
                          FirestoreServices.deleteorderDocument(data[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color:Colors.black,
                      ),
                      ),
                    ),
                  );
                  });
            }
          }
      ) ,
    );
  }
}