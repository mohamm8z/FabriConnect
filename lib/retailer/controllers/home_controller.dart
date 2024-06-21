import 'package:FabriConnect/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit(){
    getUsername();
    super.onInit();
  }

  var username='';
  getUsername() async {
    var n= await firestore.collection(usersCollection).where('Id',isEqualTo:FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['FullName'];
      }
    });

    username=n;

  }
}