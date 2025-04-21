import 'package:flutter/material.dart';
import 'package:shopify/utils/custom.dart';

class Productdetails extends StatelessWidget {
  Productdetails({
    required this.text,
    required this.desc,
    required this.img,
    required this.price,
  });

  final String text;
  final String price;
  final String desc;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(img, width: 250.0),
              SizedBox(height: 20.0),
              Customcomponents.getCustomText(
                text: text,
                clr: Colors.black,
                weight: FontWeight.w800,
                size: 32.0,
              ),
              SizedBox(height: 10.0),
              Customcomponents.getCustomText(
                text: "\$ $price",
                clr: Colors.black,
                weight: FontWeight.w600,
                size: 28.0,
              ),
              SizedBox(height: 10.0),
              Customcomponents.getCustomText(
                text: desc,
                clr: Colors.black,
                weight: FontWeight.w400,
                size: 18.0,
              ),
              SizedBox(height: 180.0),
              ElevatedButton(onPressed: () {}, child: Text("Add to cart")),
            ],
          ),
        ),
      ),
    );
  }
}
