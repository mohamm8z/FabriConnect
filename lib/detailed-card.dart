import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget detailscard({width,String? count,String? title}){
  return Container(
    padding: EdgeInsets.all(4),
    width: 100,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0)),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count!,style: TextStyle(fontSize: 20),),
          Container(
            height: 5,
          ),
          Text(title!,style: TextStyle(fontSize: 16),),
        ],

      )
  );
}