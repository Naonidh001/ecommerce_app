import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/data/authprovider.dart';
import 'package:shopify/data/filterprovider.dart';
import 'package:shopify/data/productprovider.dart';
import 'package:shopify/repository/products.dart';
import 'package:shopify/screens/components/filtercard.dart';
import 'package:shopify/screens/components/producard.dart';
import 'package:shopify/screens/components/searchquery.dart';
import 'package:shopify/screens/profilescreen.dart';
import 'package:shopify/utils/custom.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List _products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final data = await getAllProducts(); // Replace with your actual API call
      setState(() {
        _products = data;
        _isLoading = false;
      });
      Provider.of<ProductProvider>(context, listen: false).updateProducts(data);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authprovider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Customcomponents.getCustomText(
          text: "Products",
          clr: Colors.black,
          weight: FontWeight.w700,
          size: 28.0,
        ),
        leading: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder:
                  (context) => SingleChildScrollView(
                    child: Container(
                      height: 550.0,
                      padding: const EdgeInsets.all(12.0),
                      child: const Filtercard(),
                    ),
                  ),
            );
          },
          child: const Icon(Icons.filter, size: 28.0, color: Colors.black),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profilescreen(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 21,
                backgroundImage: NetworkImage(
                  authProvider.user?.image ??
                      "https://liccar.com/wp-content/uploads/png-transparent-head-the-dummy-avatar-man-tie-jacket-user.png",
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchQuery(),
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _error != null
                    ? Center(child: Text("Error: $_error"))
                    : Provider.of<ProductProvider>(context).products.isEmpty
                    // Show message when no products are available
                    ? Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(12),
                      child: Text("No items found"),
                    )
                    : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            0.65, // Adjust this ratio based on the card content
                      ),
                      itemCount:
                          Provider.of<ProductProvider>(
                            context,
                            listen: true,
                          ).products.length,
                      itemBuilder: (context, index) {
                        final product =
                            Provider.of<ProductProvider>(
                              context,
                              listen: false,
                            ).products[index];
                        return ProductCard(
                          title: product['title'],
                          price: product['price'].toString(),
                          image: product['thumbnail'],
                          desc: product['description'],
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
