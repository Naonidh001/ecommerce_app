import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopify/screens/loginscreen.dart';
import 'package:shopify/utils/custom.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer((Duration(seconds: 3)), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginscreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Customcomponents.getCustomText(
          text: "Shopify",
          clr: const Color.fromARGB(255, 100, 60, 60),
          weight: FontWeight.w700,
          size: 58.0,
        ),
      ),
    );
  }
}
