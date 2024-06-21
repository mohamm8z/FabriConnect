import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialogue(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "confirm".text.size(18).color(Colors.black).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(16).color(Colors.black).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: (){
                SystemNavigator.pop();
              }, child: Text("Yes",style: TextStyle(color: Colors.white),
            ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              }, child: Text("No",style: TextStyle(color: Colors.white),
            ),
            )
          ],
        )
      ],
    ).box.color(Vx.gray50).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}