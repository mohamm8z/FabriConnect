import 'package:FabriConnect/constants/sizes.dart';
import 'package:FabriConnect/constants/text_strings.dart';
import 'package:FabriConnect/retailer/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: myFormHeight - 10),
        child: Obx(()=>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: myEmail,
                      hintText: myEmail,
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: myFormHeight - 20),
                TextFormField(
                  controller: controller.password,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    labelText: myPassword,
                    hintText: myPassword,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_sharp),
                    ),
                  ),
                ),
                const SizedBox(height: myFormHeight - 20),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //       onPressed:1 () {
                //         ForgetPasswordScreen.buildShowModalBottomSheet(context);
                //       },
                //       child: const Text(myForgetPassword)),
                // ),
                controller.isloading.value?Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child:CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      )),
                ):
                SizedBox(
                  width: double.infinity,
                  child:ElevatedButton(
                    onPressed: () {
                      controller.isloading(true);
                      if (_formKey.currentState!.validate()) {
                        LoginController.instance.loginUser(controller.email.text.trim(), controller.password.text.trim());
                      }
                    },
                    child: Text(myLogin.toUpperCase()),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
