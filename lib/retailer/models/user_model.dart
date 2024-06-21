import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  String? cart_count;
  String? wishlist_count;
  String? order_count;
  String? imgurl;
  final String fullName;
  final String email;
  final String? phoneNo;
  final String password;
  
  UserModel({
    this.cart_count,
    this.wishlist_count,
    this.order_count,
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    this.phoneNo,
    this.imgurl,
  });

  //firebase does not stores data directly we need to convert data into json format
  toJson() {
    return {
      "Cart_count":"00",
      "Wishlist_count":"00",
      "Order_count":"00",
      "Id":id,
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "Imgurl":"",
    };
  }

  //fetching model
  // Map user fetched from firebase to userModel
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data = document.data()!;//.data provides complete object .get provides particular value e.g. email
        return UserModel(
          imgurl: data["Imgurl"],
          cart_count: data["Cart_count"],
            wishlist_count: data["Wishlist_count"],
            order_count: data["Order_count"],
            id: document.id,
            email: data["Email"],//here "Email" is namne of column in database
            password: data["Password"],
            fullName: data["FullName"],
            phoneNo: data["Phone"]);
  }
}
