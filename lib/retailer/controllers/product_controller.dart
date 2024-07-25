import 'package:FabriConnect/authentication_repository/authentication_repository.dart';
import 'package:FabriConnect/category_model.dart';
import 'package:FabriConnect/firebase_consts.dart';
import 'package:FabriConnect/main.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class productController extends GetxController{

  var subcat = [];
  var quantity=0.obs;
  var colorIndex =0.obs;
  var totalPrice=0.obs;

  var isFav=false.obs;
  getSubCategories(title) async{
    subcat.clear();
    var data= await rootBundle.loadString("lib/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s= decoded.categories.where((element)=>element.name==title).toList();
    for(var e in s[0].subcategory){
      subcat.add(e);
    }
  }

  changeColorIndex(Index){
    colorIndex.value = Index;
  }

  increaseQuantity(totalquantity){
    if(quantity.value<totalquantity) {
      quantity.value++;
    }
  }

  decreaseQuantity(){
    if(quantity.value>0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price){
    totalPrice.value = price*quantity.value;
  }

  addToCart(
      title,img,sellername,Color,qty,vendorId,tprice,id,context
      ) async{
    await firestore.collection(cartCollection).doc().set({
      'title':title,
      'img':img,
      'sellername':sellername,
      'color':Color,
      'qty':qty,
      'vendor_id':vendorId,
      'tprice':tprice,
      'added_by':id,
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetvalues(){
    totalPrice.value=0 ;
    quantity.value=0;
    colorIndex.value=0;
  }

  addToWishList(docId,context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    },SetOptions(merge:true));
    isFav(true);
    VxToast.show(context, msg: "Added to Favourite");
  }

  removeFromWishList(docId,context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    },SetOptions(merge:true));
    isFav(false);
    VxToast.show(context, msg: "Removed from Favourite");
  }

  checkIfFav(data) async {
    if(data['p_wishlist'].contains(FirebaseAuth.instance.currentUser!.uid)){
      isFav(true);
    }
    else{
      isFav(false);
    }
  }
}