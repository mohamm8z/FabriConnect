import 'package:FabriConnect/firestore_services.dart';
import 'package:FabriConnect/order_place_details.dart';
import 'package:FabriConnect/order_status.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl ;

class OrdersDetails extends StatelessWidget{
  final dynamic data;
  const OrdersDetails({Key?key,this.data}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         title: "Order Details".text.make(),

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              orderStatus(Icons.done, Colors.red, "Placed",data['order_placed']),
              orderStatus(Icons.thumb_up, Colors.blue, "Confirmed",data['order_confirmed']),
              orderStatus(Icons.car_crash, Colors.yellow, "On Delivery",data['order_on_delivery']),
              orderStatus(Icons.done_all_rounded, Colors.purple, "Delivered",data['order_delivered']),

              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderplaceDetails("Order Code","Shipping Method",data['order_code'],data['shipping_method']),
                  orderplaceDetails("Order Date","Payment Method",intl.DateFormat().add_yMd().format(data['order_date'].toDate()),data['payment_method']),
                  orderplaceDetails("Payment Status","Delivery Status ","unpaid","Order Placed"),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total amount".text.make(),
                              "${data['total_amount']}".text.color(Colors.red).make(),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),

              Divider(),
              10.heightBox,

              "Ordered Product".text.size(16).color(Colors.black).makeCentered(),

              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderplaceDetails(
                          data['orders'][index]['title'],
                          data['orders'][index]['tprice'],
                          "${data['orders'][index]['qty']}x",
                          "Refundable",
                  ),
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: 16),
                         child:Container(
                         width: 30,
                         height: 20,
                         color: Color(data['orders'][index]['color']),
                       ),
                       ),

                        const Divider(),
                      ],
                    );
                }).toList(),
              ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4)).make(),

              20.heightBox,

            ],
          ),
        ),
      ),
    );
  }

}