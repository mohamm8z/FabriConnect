import 'package:FabriConnect/profile.dart';
import 'package:FabriConnect/category.dart';
import 'package:FabriConnect/items.dart';
import 'package:FabriConnect/retailer/controllers/product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class men extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    // var controller = Get.put(productController());
    return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Mens",style: TextStyle(color: Colors.white),),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: categoryListMen.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: 250),
                itemBuilder: (context,index){
                  return Container(

                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0)),
                    ),
                    child: InkWell(
                      onTap:(){
                        // controller.getSubCategories(categoryList[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>items(categoryListMen[index])));
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            width: 150,
                            child: Center(
                              child: Image.asset(categoryimagesMen[index],
                                height: 150,
                                width: 150,
                              ),
                            ),
                          ),
                          Text(categoryListMen[index],style: TextStyle(fontSize: 20),),
                          // Image.asset
                        ], //<Widget>[]
                      ),
                    ),
                  );
                }),

          ),
        ));
  }
}