import 'package:FabriConnect/firestore_services.dart';
import 'package:FabriConnect/item_detail.dart';
import 'package:FabriConnect/men.dart';
import 'package:FabriConnect/profile.dart';
import 'package:FabriConnect/category.dart';
import 'package:FabriConnect/retailer/controllers/product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class items extends StatelessWidget{
  var categorytype;
  items(this.categorytype);

  @override
  Widget build(BuildContext context){
    var controller = Get.put(productController());

    return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text(categorytype,style: TextStyle(color: Colors.white),),
          ),
          body: StreamBuilder(
            stream: FirestoreServices.getProducts(categorytype),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
            {
              if(!snapshot.hasData){
                return Center(
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                );
              }
              else if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: Text("No products found",style: TextStyle(color: Colors.black),),
                );
              }
              else{
                var data = snapshot.data!.docs;
                return Container(
                  height: 330,
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: 300),
                      itemBuilder: (context,index){
                        return Container(

                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0)),
                          ),
                          child: InkWell(
                            onTap:(){
                              controller.checkIfFav(data[index]);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>item_detail(
                                  "${data[index]['p_name']}",
                                  data[index])));
                            },
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 200,
                                  width: 150,
                                  child: Center(
                                    child: Image.network(data[index]['p_imgs'][0],
                                      height: 150,
                                      width: 150,
                                    ).box.rounded.clip(Clip.antiAlias).make(),
                                  ),
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: Text("${data[index]['p_name']}",style: TextStyle(fontSize: 20),
                                    )),
                                SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: Text("${data[index]['p_price']}".numCurrency,style: TextStyle(fontSize: 20,color: Colors.red),
                                    )),
                                // Image.asset
                              ], //<Widget>[]
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          )
        ));
  }
}