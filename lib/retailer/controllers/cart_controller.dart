import 'package:FabriConnect/firebase_consts.dart';
import 'package:FabriConnect/retailer/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class CartController extends GetxController {

  var totalP = 0.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex=0.obs;
  var vendors=[];

  var placingOrder=false.obs;

  late dynamic productSnapshot;
  var products=[];
  calculate(data) {
    totalP.value=0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index){
    paymentIndex.value=index;
  }

  placeMyorder(orderPaymentMethod,totalamount,name) async {
    placingOrder(true);
    await getProductsDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code':Random().nextInt(1000000000),
      'order_date':FieldValue.serverTimestamp(),
      'order_by':FirebaseAuth.instance.currentUser!.uid,
      'order_by_name':name,
      'order_by_email':FirebaseAuth.instance.currentUser!.email,
      'order_by_address':addressController.text,
      'order_by_state':stateController.text,
      'order_by_city':cityController.text,
      'order_by_phone':phoneController.text,
      'order_by_postalcode':postalcodeController.text,
      'shipping_method':"Home delivery",
      'payment_method':orderPaymentMethod,
      'order_placed':true,
      'order_confirmed':false,
      'order_delivered':false,
      'order_on_delivery':false,
      'total_amount':totalamount,
      'orders':FieldValue.arrayUnion(products),
      'vendors':FieldValue.arrayUnion(vendors)
    });
    placingOrder(false);
  }

  getProductsDetails(){
    products.clear();
    vendors.clear();
    for(var i=0;i<productSnapshot.length;i++){
      products.add({
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'vendor_id':productSnapshot[i]['vendor_id'],
        'tprice':productSnapshot[i]['tprice'],
        'qty':productSnapshot[i]['qty'],
        'title':productSnapshot[i]['title'],
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  clearCart(){
    for(var i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}