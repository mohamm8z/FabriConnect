import 'package:FabriConnect/constants/image_strings.dart';
import 'package:FabriConnect/constants/sizes.dart';
import 'package:FabriConnect/constants/text_strings.dart';
import 'package:FabriConnect/retailer/controllers/signup_controller.dart';
import 'package:FabriConnect/retailer/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: myFormHeight - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              SignUpController.instance.registerUserWithGoogle();
            },
            icon: const Image(
              image: AssetImage(myGoogleLogo),
              width: 20.0,
            ),
            label: Text(mySignInWithGoogle.toUpperCase()),
          ),

        ),
        const SizedBox(height: myFormHeight - 20),
        TextButton(
          onPressed: () {
            Get.offAll(const LoginScreen());
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: myAlreadyHaveAnAccount,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextSpan(text: myLogin.toUpperCase())
          ])),
        )
      ],
    );
  }
}