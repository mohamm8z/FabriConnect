import 'package:b2b/payment_method.dart';
import 'package:b2b/retailer/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget{
  const ShippingDetails({super.key});
  @override
  Widget build(BuildContext context){
    var controller= Get.put(CartController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: "Shipping Info".text.color(Colors.black).make(),
        ),
        bottomNavigationBar:
        SizedBox(
          height: 60,
          child: ElevatedButton(onPressed: (){
            if(controller.addressController.text.length>10){
              Get.to(()=>const PaymentMethods());
            }
            else
              {
                VxToast.show(context, msg: "Please fill the form");
              }
          },
            child: Text("Continue", style: TextStyle(color: Colors.white),),),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Address",style: TextStyle(color: Colors.orange,fontSize: 16),),
                      ),
                      TextFormField(
                        controller: controller.addressController,
                        decoration: const InputDecoration(
                            hintText: "Address",
                            border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("City",style: TextStyle(color: Colors.orange,fontSize: 16),),
                      ),
                      TextFormField(
                        controller: controller.cityController,
                        decoration: const InputDecoration(
                            hintText: "City",
                            border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("State",style: TextStyle(color: Colors.orange,fontSize: 16),),
                      ),
                      TextFormField(
                        controller: controller.stateController,
                        decoration: const InputDecoration(
                            hintText: "State",
                            border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Postal Code",style: TextStyle(color: Colors.orange,fontSize: 16),),
                      ),
                      TextFormField(
                        controller: controller.postalcodeController,
                        decoration: const InputDecoration(
                            hintText: "Postal Code",
                            border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Phone",style: TextStyle(color: Colors.orange,fontSize: 16),),
                      ),
                      TextFormField(
                        controller: controller.phoneController,
                        decoration: const InputDecoration(
                            hintText: "Phone",
                            border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}