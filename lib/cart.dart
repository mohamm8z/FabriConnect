import 'package:FabriConnect/constants/colors.dart';
import 'package:FabriConnect/firestore_services.dart';
import 'package:FabriConnect/item_detail.dart';
import 'package:FabriConnect/main.dart';
import 'package:FabriConnect/retailer/controllers/cart_controller.dart';
import 'package:FabriConnect/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class cart extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    var controller =Get.put(CartController());
    
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar:
      //  SizedBox(
      //   height: 60,
      //   child: ElevatedButton(onPressed: (){
      //     Get.to(()=>ShippingDetails());
      //   },
      //     child: Text("Proceed to Shipping", style: TextStyle(color: Colors.white),),),
      // ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cart'),),
      body:StreamBuilder(
          stream: FirestoreServices.getCart(FirebaseAuth.instance.currentUser!.uid),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            var data=snapshot.data!.docs;
            if(!snapshot.hasData){
              return Center(
                child:  CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              controller.productSnapshot=data;
              return Center(
                  child: "cart is Empty".text.color(Colors.black).make(),
              );
            }
            else{
              controller.calculate(data);
              controller.productSnapshot=data;
              return Column(
                children: [
                  Expanded(
                      child: Container(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context,int index){
                              return ListTile(
                                leading: Image.network("${data[index]['img']}",width: 80,fit: BoxFit.cover,),
                                title: "${data[index]['title']} (x${data[index]['qty']})".text.size(16).make(),
                                subtitle: "${data[index]['tprice']}".numCurrency.text.color(Colors.red).make(),
                                trailing: Icon(Icons.delete,color: Colors.red,).onTap(() {
                                   FirestoreServices.deleteDocument(data[index].id);
                                }),
                              );
                            }
                        ),
                      ),

                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price".text.color(Colors.black).make(),
                      Obx(()=>"${controller.totalP.value}".numCurrency.text.color(Colors.red).make())
                    ],
                  ).box.padding(EdgeInsets.all(12)).color(golden).width((MediaQuery.of(context).size.width)-60).roundedSM.make(),

                  10.heightBox,

                SizedBox(
                   height: 60,
                   width: MediaQuery.of(context).size.width,
                   child: ElevatedButton(onPressed: (){
                     Get.to(()=>ShippingDetails());
                   },
                     child: Text("Proceed to Shipping", style: TextStyle(color: Colors.white),),),
                 ),
                ],
              );
            }
          })

    );
  }
}