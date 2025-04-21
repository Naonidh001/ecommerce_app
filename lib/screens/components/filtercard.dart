import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/data/filterprovider.dart';
import 'package:shopify/data/productprovider.dart';
import 'package:shopify/repository/filterproduct.dart';
import 'package:shopify/repository/products.dart';
import 'package:shopify/screens/components/categorycard.dart';
import 'package:shopify/screens/components/sortcard.dart';
import 'package:shopify/utils/custom.dart';

class Filtercard extends StatefulWidget {
  const Filtercard({super.key});

  @override
  State<Filtercard> createState() => _FiltercardState();
}

class _FiltercardState extends State<Filtercard> {
  List<String> filterList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SortFilter(),
                    Divider(),
                    Categorycard(), // This should use shrinkWrap list view inside
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const ApplyFilter(),
    );
  }
}

class ApplyFilter extends StatelessWidget {
  const ApplyFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Customcomponents.getCustomButton(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Reset")],
                ),
                onPressedFunc: () async {
                  Provider.of<Filterprovider>(
                    context,
                    listen: false,
                  ).resetFilter();
                  final newData = await getAllProducts();
                  //print(newData);
                  Provider.of<ProductProvider>(
                    context,
                    listen: false,
                  ).updateProducts(newData);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Customcomponents.getCustomButton(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Apply")],
                ),
                onPressedFunc: () async {
                  if (Provider.of<Filterprovider>(
                    context,
                    listen: false,
                  ).selectCat.isNotEmpty) {
                    final catList =
                        Provider.of<Filterprovider>(
                          context,
                          listen: false,
                        ).selectCat;
                    final newData = await fetchAllCategories(catList);
                    //print(newData);
                    Provider.of<ProductProvider>(
                      context,
                      listen: false,
                    ).updateProducts(newData);
                    Navigator.pop(context);
                  } else {
                    final newData = await getAllProducts();
                    Provider.of<ProductProvider>(
                      context,
                      listen: false,
                    ).updateProducts(newData);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
