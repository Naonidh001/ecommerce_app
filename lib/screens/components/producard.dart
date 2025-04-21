import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopify/screens/productDetails.dart';
import 'package:shopify/utils/custom.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.title,
    required this.price,
    required this.image,
    required this.desc,
    super.key,
  });

  final String title;
  final String price;
  final String image;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => Productdetails(
                    text: title,
                    desc: desc,
                    img: image,
                    price: price,
                  ),
            ),
          ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image with limited height
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              // child: Image.network(
              //   image,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              child: Image.network(
                image,
                width: double.infinity,
                height: 180, // <-- Reserve the space
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null)
                    return child; // Image is fully loaded

                  // While it's loading, show a placeholder (e.g., a spinner)
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  // If image fails to load, show a fallback
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            // Padding around text content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Customcomponents.getCustomText(
                    text: title,
                    clr: Colors.black,
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                  const SizedBox(height: 4),
                  Customcomponents.getCustomText(
                    text: "\$ $price",
                    clr: Colors.green[700] ?? Colors.green,
                    weight: FontWeight.w600,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
