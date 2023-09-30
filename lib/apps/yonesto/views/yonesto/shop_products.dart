import 'package:flutter/material.dart';
import 'package:unicapp/core/yonesto/models/product.dart';
import '../../molecules/package.dart';
import '../diialogs/info.dart';

class ShopProducts extends StatelessWidget {
  const ShopProducts({super.key, required this.displayProducts});

  final List<Product> displayProducts;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Wrap(
                  spacing: 0, // Espacio horizontal entre contenedores
                  runSpacing: 0,

                  children: List.generate(
                    displayProducts.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return InfoProductAlertDialog(
                                  product: displayProducts[index],
                                  index: index,
                                );
                              });
                        },
                        child: ShoppingCard(
                          index: index,
                          product: displayProducts[index],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height / 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
