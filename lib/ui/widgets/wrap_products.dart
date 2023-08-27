import 'package:flutter/material.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/ui/widgets/shopping_card.dart';

class WrapProducts extends StatelessWidget {
  const WrapProducts({super.key, required this.displayProducts});

  final List<Product> displayProducts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Wrap(
                spacing: 20, // Espacio horizontal entre contenedores
                runSpacing: 20,

                children: List.generate(
                  displayProducts.length,
                  (index) {
                    return ShoppingCard(
                      index: index,
                      product: displayProducts[index],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
