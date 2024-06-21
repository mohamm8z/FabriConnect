import 'package:FabriConnect/firebase_consts.dart';

class FirestoreServices{
  static getUser(uid){
    return firestore.collection("Users").where('Id',isEqualTo:uid).snapshots();
  }
}