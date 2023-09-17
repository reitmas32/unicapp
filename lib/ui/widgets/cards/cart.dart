import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/providers/cart.dart';

class CartCard extends StatelessWidget {
  CartCard({
    super.key,
    required this.product,
  });

  final Product product;
  final List<bool> starStates = [true, true, true, false, false];

  @override
  Widget build(BuildContext context) {
    final currentColor = Provider.of<ThemeProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    return Card(
      color: currentColor.isDarkTheme()
          ? const Color.fromARGB(255, 35, 34, 34)
          : const Color.fromARGB(255, 199, 197, 197),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://www.generaldistributionlc.com/cdn/shop/products/Sabritas-Chetos-Flaming-150gr.png?v=1558976038',
                  height: 150,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        starStates[index] ? Icons.star : Icons.star_border,
                        color: Colors.purple,
                        size: 15,
                      ),
                    ),
                  ),
                  Text('${product.stock} Unidades'),
                  Row(
                    children: [
                      Text('\$${product.salePrice}'),
                    ],
                  )
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  cart.deleteToCart(product);
                  var snackBar = SnackBar(
                    content: Text(
                      '¡Se Eliminaron todos los ${product.name} del Carrito!',
                      style: TextStyle(
                        color: currentColor.isDarkTheme()
                            ? const Color.fromARGB(255, 199, 197, 197)
                            : const Color.fromARGB(255, 35, 34, 34),
                      ),
                    ),
                    duration: const Duration(milliseconds: 750),
                    backgroundColor: currentColor.isDarkTheme()
                        ? const Color.fromARGB(255, 35, 34, 34)
                        : const Color.fromARGB(
                            255, 199, 197, 197), // Duración de la visibilidad
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(child: const Icon(Icons.delete)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
