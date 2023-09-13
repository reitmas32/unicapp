import 'package:flutter/material.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/ui/widgets/shopping_card.dart';

class WrapProducts extends StatelessWidget {
  const WrapProducts({super.key, required this.displayProducts});

  final List<Product> displayProducts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Wrap(
              spacing: 0, // Espacio horizontal entre contenedores
              runSpacing: 0,

              children: List.generate(
                displayProducts.length,
                (index) {
                  return Container(
                    child: ShoppingCard(
                      index: index,
                      product: displayProducts[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
