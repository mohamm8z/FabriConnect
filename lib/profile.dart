import 'package:b2b/Profile_update.dart';
import 'package:b2b/authentication_repository/authentication_repository.dart';
import 'package:b2b/firestore_services.dart';
import 'package:b2b/messaging_screen.dart';
import 'package:b2b/orders_screen.dart';
import 'package:b2b/retailer/controllers/profile_controller.dart';
import 'package:b2b/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:b2b/category.dart';
import 'package:get/get.dart';
import 'package:b2b/detailed-card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
class profile extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var controller=Get.put(ProfileController());

    return Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                );
              }
              else{

                var data=snapshot.data!.docs[0];

                return Container(
                  height: 680,
                  decoration: BoxDecoration(
                    color: Color(0xFFe1e0dc),
                    image: DecorationImage(image: AssetImage("assets/images/orange1.jpg"),fit: BoxFit.cover),
                  ),

                  child: Column(
                    children: [

                      Container(
                        height: 40,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Align(
                          alignment: Alignment.topRight,child: Icon(Icons.edit,color: Colors.white,)
                        ).onTap(() {
                          controller.namecontroller.text=data["FullName"];
                          Get.to(()=>Profile_update(data: data,));
                        }),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            data['Imgurl']==''?
                            Container(
                              height: 70,
                              width: 80,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage('assets/images/Nihal.JPG'),
                                ),
                              ),
                            ):
                                Image.network(data['Imgurl'],width: 80,height:80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),

                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data["FullName"]}",style: TextStyle(color: Colors.white),),
                                  Text("${data["Email"]}",style: TextStyle(color: Colors.white),),
                                ],
                              )),
                            ),
                            OutlinedButton(
                                style:OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.white,
                                    )
                                ) ,
                                onPressed: (){
                                  AuthenticationRepository.instance.logOut();
                                  Get.snackbar("Success", "you are logged out successfully.",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green.withOpacity(0.1),
                                      colorText: Colors.green);
                                },
                                child: Text("Log Out",style: TextStyle(color: Colors.white),))
                          ],
                        ),
                      ),

                      Container(
                        height: 20,
                      ),

                      FutureBuilder(
                        future:FirestoreServices.getCount(),
                        builder:(BuildContext context,AsyncSnapshot snapshot){
                          if(!snapshot.hasData){
                            return
                              Center(
                                child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.red),
                            ),
                              );
                          }
                          else
                            {
                              var countdata=snapshot.data;
                              return Row(
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                                children: [
                                  detailscard(count: countdata[0].toString(),title: "your cart"),
                                  detailscard(count: countdata[1].toString(),title: "your wishlist"),
                                  detailscard(count: countdata[2].toString(),title: "your orders"),
                                ],
                              );
                            }
                        }
                      ),

                      Container(
                        height: 50,
                      ),


                      Container(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 25,
                                )
                              ]
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context,index){
                              return Divider(
                                color: Colors.grey,
                              );
                            },
                            itemCount:profiledetails.length,
                            itemBuilder: (BuildContext context,int index){
                              return ListTile(
                                onTap: (){
                                  switch(index){
                                    case 0:
                                      Get.to(()=>OrdersScreen());
                                      break;
                                    case 1:
                                      Get.to(()=>WishlistScreen());
                                      break;
                                    case 2:
                                      Get.to(()=>MessageScreen());
                                      break;

                                  }
                                },
                                leading: Image.asset(
                                  profileimages[index],
                                  width: 35,
                                ),
                                title: Text(profiledetails[index]),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            }
        )
      );
  }
}