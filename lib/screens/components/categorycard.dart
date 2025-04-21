import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/data/filterprovider.dart';
import 'package:shopify/repository/filterproduct.dart';
import 'package:shopify/utils/custom.dart';

class Categorycard extends StatefulWidget {
  const Categorycard({super.key});

  @override
  State<Categorycard> createState() => _CategorycardState();
}

class _CategorycardState extends State<Categorycard> {
  List data = [];
  bool _isLoading = true;
  List<String> filterList = [];

  @override
  void initState() {
    super.initState();
    fetchCategorys();
  }

  Future<void> fetchCategorys() async {
    try {
      final response = await getProductsCategory();
      setState(() {
        data = response;
        _isLoading = false;
      });
    } catch (e) {
      print("error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Customcomponents.getCustomText(
            text: "Product category",
            clr: Colors.black,
            weight: FontWeight.w600,
            size: 18.0,
          ),
          const SizedBox(height: 12.0),

          // Loader or content
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : data.isEmpty
              ? const Center(child: Text("No categories found"))
              : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = data[index];
                  var isSelected =
                      Provider.of<Filterprovider>(
                            context,
                            listen: false,
                          ).selectCat.contains(item['name'])
                          ? true
                          : false;

                  return ListTile(
                    title: Text(item['name'] ?? 'NA'),
                    trailing: Checkbox(
                      value: isSelected,
                      onChanged: (bool? newVal) {
                        if (newVal == true) {
                          Provider.of<Filterprovider>(
                            context,
                            listen: false,
                          ).addSelectedCat(item['name']);

                          setState(() {
                            isSelected = true;
                          });
                        } else {
                          Provider.of<Filterprovider>(
                            context,
                            listen: false,
                          ).removeCategory(item['name']);

                          setState(() {
                            isSelected = false;
                          });
                        }
                      },
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
