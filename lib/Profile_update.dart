import 'dart:io';
import 'package:b2b/Profile_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b2b/retailer/controllers/profile_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile_update extends StatelessWidget{

  final dynamic data;

  const Profile_update({Key?key,this.data}):super(key:key);

  @override
  Widget build(BuildContext context){
    var controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFe1e0dc),
            image: DecorationImage(image: AssetImage("assets/images/orange1.jpg"),fit: BoxFit.cover),
          ),

          child: Obx(()=>Container(

            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 12,left: 12,right: 12,bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                data['Imgurl']==''&&controller.profileImgpath.isEmpty?
                Image.asset("assets/images/Nihal.JPG",width: 120,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                 :
                data['Imgurl']!=''&&controller.profileImgpath.isEmpty?Image.network(data['Imgurl'],width: 120,).box.roundedFull.clip(Clip.antiAlias).make():
                Image.file(File(controller.profileImgpath.value),width: 120,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),


                Container(
                  height: 10,
                ),

                ElevatedButton(onPressed:(){
                  controller.changeImage(context);
                }, child: Text("Change",style: TextStyle(color: Colors.white),)),
                Divider(),
                Container(
                  height: 20,
                ),

                TextFormField(
                  controller: controller.namecontroller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: "name",
                      hintText: "name",
                      border: OutlineInputBorder()),
                ),

                Container(
                  height: 20,
                ),


                TextFormField(
                  controller: controller.oldpasscontroller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: "Old Password",
                      hintText: "Password",
                      border: OutlineInputBorder()),
                ),

                Container(
                  height: 10,
                ),

                TextFormField(
                  controller: controller.newpasscontroller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: "New password",
                      hintText: "Password",
                      border: OutlineInputBorder()),
                ),

                Container(
                  height: 10,
                ),

                controller.isLoading.value?
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ):
                SizedBox(
                    width:double.infinity,
                    child: ElevatedButton(onPressed: ()async {

                      controller.isLoading(true);
                      if(controller.profileImgpath.value.isNotEmpty)
                      {
                        await controller.uploadProfileImage(id:data.id);
                      }
                      else
                      {
                        controller.profileImgLink=data['Imgurl'];
                      }


                      if(data['Password'] == controller.oldpasscontroller.text)
                      {
                        if(controller.newpasscontroller.text.isEmpty)
                        {
                          VxToast.show(context, msg: "Enter New Password");
                          controller.isLoading(false);
                        }
                        else {
                          controller.changeAuthPassword(
                              email: data['Email'],
                              password: controller.oldpasscontroller.text,
                              newPassword: controller.newpasscontroller.text
                          );

                          await controller.updateProfile(
                            id: data.id,
                            imgurl: controller.profileImgLink,
                            name: controller.namecontroller.text,
                            password: controller.newpasscontroller.text,
                          );
                          VxToast.show(context, msg: "updated");
                        }
                      }
                      else
                      {
                        if(controller.oldpasscontroller.text.isEmpty)
                        {
                          if(controller.newpasscontroller.text.isNotEmpty) {
                            VxToast.show(context, msg: "Enter Old Password");
                            controller.isLoading(false);
                          }
                          else
                          {
                            controller.changeAuthPassword(
                                email: data['Email'],
                                password: data['Password'],
                                newPassword: data['Password']
                            );

                            await controller.updateProfile(
                              id: data.id,
                              imgurl: controller.profileImgLink,
                              name: controller.namecontroller.text,
                              password: data['Password'],
                            );
                            VxToast.show(context, msg: "updated");
                          }
                        }
                        else {
                          VxToast.show(context, msg: "Wrong Old Password");
                          controller.isLoading(false);
                        }
                      }
                      },
                        child: Text("Save",style: TextStyle(color: Colors.white),))),
              ],
            ),
          ),
        ),
      )
    )
    );
  }
}