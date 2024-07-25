import 'package:FabriConnect/category.dart';
import 'package:FabriConnect/chat_screen.dart';
import 'package:FabriConnect/firestore_services.dart';
import 'package:FabriConnect/retailer/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class item_detail extends StatelessWidget{
  final String? item_title;
  final dynamic data;
  item_detail(this.item_title,this.data);

  @override
  Widget build(BuildContext context){
   var controller = Get.put(productController());
    return StreamBuilder(
      stream: FirestoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          final dynamic userdata=snapshot.data!.docs[0];
          return WillPopScope(
            onWillPop: () async {
              controller.resetvalues();
              return true;
            },
            child: Scaffold(
              backgroundColor: Color(0xFFFFFFFF),
              appBar: AppBar(
                leading:IconButton(onPressed:(){
                   controller.resetvalues();
                   Get.back();
                }, icon:Icon(Icons.arrow_back) ),
                title: Text('$item_title'),
                actions: [
                  // IconButton(onPressed: () {}, icon: const Icon(Icons.share,)),
                  Obx(()=>IconButton(
                      onPressed: () {
                        if(controller.isFav.value){
                          controller.removeFromWishList(data.id,context);
                          controller.isFav(false);
                        }
                        else{
                          controller.addToWishList(data.id,context);
                          controller.isFav(true);
                        }
                      }, icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value?Colors.red:Colors.black,)))
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 240,
                                child: Center(
                                  child: VxSwiper.builder(
                                      autoPlay: true,
                                      height: 200,
                                      viewportFraction: 1.0,
                                      itemCount: data['p_imgs'].length,
                                      aspectRatio: 16 / 9,
                                      itemBuilder: (context, index) {
                                        return Image.network(
                                          data['p_imgs'][index],
                                          width: double.infinity,
                                          fit: BoxFit.cover,);
                                      }),
                                ),
                              ),

                              Container(
                                height: 30,
                                child: Text("$item_title", style: TextStyle(
                                    fontSize: 16, color: Color(0xFF000000)),),
                              ),

                              Container(
                                height: 40,
                                child: VxRating(
                                  isSelectable: false,
                                  value: double.parse(data['p_rating']),
                                  onRatingUpdate: (value) {},
                                  normalColor: Color(0xFFD3D3D3),
                                  selectionColor: Color(0xFFFFD700),
                                  count: 5,
                                  size: 25,
                                  maxRating: 5,
                                ),
                              ),

                              Container(
                                height: 30,
                                child: Text("${data['p_price']}".numCurrency,
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF000000)),),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 60,
                                color: Color(0xFFD3D3D3),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text("Seller", style: TextStyle(
                                                color: Colors.white),),
                                            Container(
                                              height: 20,
                                              child: Text("${data['p_seller']}"),
                                            )
                                          ],
                                        )),
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.message_rounded,
                                        color: Color(0xFF808080),),
                                    )
                                        .onTap(() {
                                      Get.to(()=>ChatScreen(),
                                      arguments: [data['p_seller'],data['vendor_id'],userdata['FullName']],
                                      );
                                    })
                                  ],
                                ),
                              ),

                              Container(
                                height: 20,
                              ),

                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 25,
                                      )
                                    ]
                                ),
                                child: Obx(
                                      () =>
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text("Color",
                                                    style: TextStyle(color: Color(
                                                        0xFF000000)),),
                                                ),
                                                Row(
                                                  children: List.generate(
                                                      data['p_colors'].length,
                                                          (index) =>
                                                          Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              VxBox()
                                                                  .size(40, 40)
                                                                  .
                                                              roundedFull
                                                                  .
                                                              color(Color(
                                                                  data['p_colors'][index])
                                                                  .withOpacity(
                                                                  1.0))
                                                                  .
                                                              margin(EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 4))
                                                                  .
                                                              make()
                                                                  .onTap(() {
                                                                controller
                                                                    .changeColorIndex(
                                                                    index);
                                                              }),

                                                              Visibility(
                                                                  visible: index ==
                                                                      controller
                                                                          .colorIndex
                                                                          .value,
                                                                  child: const Icon(
                                                                    Icons.done,
                                                                    color: Colors
                                                                        .white,)
                                                              )
                                                            ],
                                                          )
                                                  ),
                                                )
                                              ],
                                            ),

                                          ),

                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text("Quantity",
                                                    style: TextStyle(color: Color(
                                                        0xFF000000)),),
                                                ),
                                                Obx(() =>
                                                    Row(
                                                      children: [
                                                        IconButton(onPressed: () {
                                                          controller
                                                              .decreaseQuantity();
                                                          controller
                                                              .calculateTotalPrice(
                                                              int.parse(
                                                                  data['p_price']));
                                                        },
                                                            icon: const Icon(
                                                                Icons.remove)),
                                                        Text(controller.quantity
                                                            .value.toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xFF000000)),),
                                                        IconButton(onPressed: () {
                                                          controller
                                                              .increaseQuantity(
                                                              data['p_quantity']);
                                                          controller
                                                              .calculateTotalPrice(
                                                              int.parse(
                                                                  data['p_price']));
                                                        },
                                                            icon: const Icon(
                                                                Icons.add)),
                                                        // Container(
                                                        //   child: Text(
                                                        //     "(${data['p_quantity']} available)",
                                                        //     style: TextStyle(
                                                        //         color: Color(
                                                        //             0xFF000000)),),
                                                        // )
                                                      ],
                                                    ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text("Total",
                                                    style: TextStyle(color: Color(
                                                        0xFF000000)),),
                                                ),
                                                Text(
                                                  "${controller.totalPrice.value}"
                                                      .numCurrency,
                                                  style: TextStyle(fontSize: 16,
                                                      color: Color(0xFF000000)),)
                                              ],
                                            ),
                                          )

                                        ],
                                      ),
                                ),
                              ),

                              Container(
                                height: 40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Description", style: TextStyle(
                                        color: Color(0xFF000000)),),
                                  ],
                                ),
                              ),

                              Container(
                                height: 50,
                                child: Text("${data['p_desc']}",
                                  style: TextStyle(color: Color(0xFF000000)),),
                              ),

                              // ListView(
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   children: List.generate(
                              //       itemdetailsbuttontext.length, (index) =>
                              //       ListTile(
                              //         title: Text(itemdetailsbuttontext[index]),
                              //         trailing: Icon(Icons.arrow_forward),
                              //       )),
                              // ),

                              Container(
                                height: 20,
                              ),

                              // Container(
                              //   child: Text('Products you may also like',
                              //     style: TextStyle(fontSize: 16),),
                              // ),
                              //
                              // Container(
                              //   height: 20,
                              // ),
                              //
                              // SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.only(
                              //           topRight: Radius.circular(15.0),
                              //           bottomRight: Radius.circular(15.0),
                              //           topLeft: Radius.circular(15.0),
                              //           bottomLeft: Radius.circular(15.0)),
                              //     ),
                              //
                              //     margin: EdgeInsets.symmetric(horizontal: 4),
                              //     padding: EdgeInsets.all(8),
                              //     child: Row(
                              //       children: List.generate(
                              //           6,
                              //               (index) =>
                              //               Column(
                              //                 crossAxisAlignment: CrossAxisAlignment
                              //                     .start,
                              //                 children: [
                              //                   Image.asset(
                              //                     "assets/images/suit.png",
                              //                     width: 130, fit: BoxFit.cover,),
                              //                   Container(
                              //                     child: Text(
                              //                       "This is first product",
                              //                       style: TextStyle(color: Color(
                              //                           0xFF000000)),),
                              //                   ),
                              //
                              //                   Container(
                              //                     child: Text("300",
                              //                       style: TextStyle(
                              //                           color: Colors.red),),
                              //                   ),
                              //
                              //                 ],
                              //               )),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Container(
                      color: Colors.red,
                      child: ElevatedButton(
                        child: Text(
                          "Add to cart", style: TextStyle(color: Colors.white),),
                        onPressed: () {
                           if(controller.quantity.value>4){
                             controller.addToCart(
                               data['p_name'],
                               data['p_imgs'][0],
                               data['p_seller'],
                               data['p_colors'][controller.colorIndex.value],
                               controller.quantity.value,
                               data['vendor_id'],
                               controller.totalPrice.value,
                               userdata['Id'],
                               context,
                             );
                             VxToast.show(context, msg: 'Added to cart');
                           }
                           else{
                             VxToast.show(context, msg: "Minimum 5 product is required");
                           }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
    );
  }
}