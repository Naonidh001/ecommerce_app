import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/data/authprovider.dart';
import 'package:shopify/data/filterprovider.dart';
import 'package:shopify/data/productprovider.dart';
import 'package:shopify/screens/loginscreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authprovider()),
        ChangeNotifierProvider(create: (context) => Filterprovider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        initialRoute: "/login",
        routes: {"/login": (context) => Loginscreen()},
      ),
    ),
  );
}
