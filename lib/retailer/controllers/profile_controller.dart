import 'dart:io';
import 'package:FabriConnect/authentication_repository/authentication_repository.dart';
import 'package:FabriConnect/firebase_consts.dart';
import 'package:FabriConnect/retailer/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:FabriConnect/authentication_repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileController extends GetxController {
  var profileImgpath = ''.obs;
  var profileImgLink ='';
  var isLoading = false.obs;
  var id="";
  var namecontroller=TextEditingController();
  var oldpasscontroller=TextEditingController();
  var newpasscontroller=TextEditingController();

  changeImage(context) async{
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
      if(img==null)
        return;
      profileImgpath.value=img.path;
    }on PlatformException catch(e)
    {
        print(e);
    }
  }

  uploadProfileImage({id}) async{
    var filename = basename(profileImgpath.value);
    var destination = 'images/${id}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgpath.value));
    profileImgLink= await ref.getDownloadURL();
  }

  updateProfile({id,name,password,imgurl}) async{

      var store = await firestore.collection("Users").doc(id);
      await store.set({
        'FullName': name,
        'Password': password,
        'Imgurl': imgurl,
      }, SetOptions(merge: true));

    isLoading(false);
  }

  changeAuthPassword({email,password,newPassword}) async{
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(cred).then((value){
      FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    }).catchError((error){
      print(error.toString());
    });
  }

}


