import 'package:FabriConnect/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isloading=false.obs;
  static LoginController get instance => Get.find();

  //Textfield controller to get the data from Textfeilds
  final email = TextEditingController();
  final password = TextEditingController();

  //Call this Function from Design & it will do the rest
  Future<void> loginUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);
    if (error != null) {
      isloading(false);
      Get.snackbar("Error :", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    } else {
      Get.snackbar("Success :", "You are logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent.withOpacity(0.1),
          colorText: Colors.green);
    }
  }

  Future<void> loginUserWithGoogle()async {

    String? error = await AuthenticationRepository.instance.signInWithGoogle();
    if (error != null)
    {
      Get.snackbar("Error :",error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
    else
    {
      Get.snackbar("Success :", "You are logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent.withOpacity(0.1),
          colorText: Colors.green);
    }
  }
}
