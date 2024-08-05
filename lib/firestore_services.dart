import 'package:b2b/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices{
  static getUser(uid){
    return firestore.collection("Users").where('Id',isEqualTo:uid).snapshots();
  }

  static getProducts(category){
    return firestore.collection("Products").where('p_subcategory',isEqualTo:category).snapshots();
  }

  static getCart(uid){
    return firestore.collection("Cart").where('added_by',isEqualTo:uid).snapshots();
  }

  static deleteDocument(docId){
    return firestore.collection("Cart").doc(docId).delete();
  }

  static deleteorderDocument(docId){
    return firestore.collection("Orders").doc(docId).delete();
  }
  static getChatMessages(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).
    orderBy('created_on',descending: false).snapshots();
  }

  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots();
  }

  static getWishlists(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains:FirebaseAuth.instance.currentUser!.uid).snapshots();
  }

  static getAllMessages(){
    return firestore.collection(chatsCollection).where('fromid',isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots();
  }

  static getCount() async {
    var res= await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo:FirebaseAuth.instance.currentUser!.uid).get().then(
              (value) {
                 return value.docs.length;
              }),
      firestore.collection(productsCollection).where('p_wishlist',arrayContains:FirebaseAuth.instance.currentUser!.uid).get().then(
              (value) {
            return value.docs.length;
          }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo:FirebaseAuth.instance.currentUser!.uid).get().then(
              (value) {
            return value.docs.length;
          })
    ]);
    return res;
  }

  static allProducts(){
     return firestore.collection(productsCollection).snapshots();
  }
}