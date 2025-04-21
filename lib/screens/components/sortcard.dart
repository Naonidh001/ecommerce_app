import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/data/filterprovider.dart';
import 'package:shopify/data/productprovider.dart';
import 'package:shopify/utils/custom.dart';

class SortFilter extends StatelessWidget {
  const SortFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<Filterprovider>(context);
    final setAscOrder = filterProvider.isAsc;
    final setDscOrder = filterProvider.isDsc;

    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Customcomponents.getCustomText(
            text: "Sort via",
            clr: Colors.black,
            weight: FontWeight.w600,
            size: 18.0,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Customcomponents.getCustomButton(
                  clr: setAscOrder ? Colors.blue : Colors.white,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_drop_down_rounded),
                      Text("Low"),
                    ],
                  ),
                  onPressedFunc: () {
                    filterProvider.setAsc(true);
                    filterProvider.setDsc(false);

                    Provider.of<ProductProvider>(
                      context,
                      listen: false,
                    ).sortAsc();

                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Customcomponents.getCustomButton(
                  clr: setDscOrder ? Colors.blue : Colors.white,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.arrow_drop_up_rounded), Text("High")],
                  ),
                  onPressedFunc: () {
                    filterProvider.setAsc(false);
                    filterProvider.setDsc(true);

                    Provider.of<ProductProvider>(
                      context,
                      listen: false,
                    ).sortDsc();

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
