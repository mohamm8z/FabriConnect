import 'package:FabriConnect/category.dart';
import 'package:FabriConnect/firestore_services.dart';
import 'package:FabriConnect/main.dart';
import 'package:FabriConnect/retailer/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethods extends StatelessWidget{
  const PaymentMethods({Key?key}):super(key:key);

  @override
  Widget build(BuildContext context){

    var controller= Get.put(CartController());
    return StreamBuilder(
        stream: FirestoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
      final dynamic data=snapshot.data!.docs[0];
      return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: SizedBox(
              height: 60,
              child: ElevatedButton(onPressed: () async {
                await controller.placeMyorder(
                    paymentMethodsList[controller.paymentIndex.value],
                    controller.totalP.value,data['FullName']);
                await controller.clearCart();
                controller.totalP.value=0;
                VxToast.show(context, msg: "Order placed succesfully");
                Get.offAll(MyHomePage());
              },
                child: Text(
                  "Place my order", style: TextStyle(color: Colors.white),),),
            ),
            appBar: AppBar(
              title: "Choose Payment Method".text.color(Colors.black).make(),

            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(() =>
                  Column(
                      children: List.generate(
                          paymentMethodsimageList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.paymentIndex(index);
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: controller.paymentIndex.value == index
                                      ? Colors.red
                                      : Colors.transparent,
                                  width: 4,
                                )),
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.asset(
                                  paymentMethodsimageList[index],
                                  width: double.infinity,
                                  height: 120,
                                  colorBlendMode: controller.paymentIndex.value ==
                                      index ? BlendMode.darken : BlendMode.color,
                                  color: controller.paymentIndex.value == index
                                      ? Colors.black.withOpacity(0.4)
                                      : Colors.transparent,
                                  fit: BoxFit.cover,),
                                controller.paymentIndex.value == index ? Transform
                                    .scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ), value: true, onChanged: (value) {}
                                  ),
                                ) : Container(),

                                Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: paymentMethodsList[index].text.white
                                        .size(16).make()),
                              ],
                            ),
                          ),
                        );
                      })
                  ),
              ),
            )
      );

    }
    );
  }
}