import 'package:FabriConnect/constants/image_strings.dart';
import 'package:FabriConnect/constants/text_strings.dart';
import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(myShopingBasketWithPhone),
            height: size.height * 0.2),
        Text(myLoginTitle, style: Theme.of(context).textTheme.headlineMedium),
        Text(myLoginSubTitle, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}