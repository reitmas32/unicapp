import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/providers/cart.dart';

class RemoveToCartButton extends StatelessWidget {
  const RemoveToCartButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final size = MediaQuery.of(context).size;
    final currentColor = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: () {
        cart.removeToCart(product);
        var snackBar = SnackBar(
          content: Text(
            '¡Se Elimino un ${product.name} al Carrito!',
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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: size.width > 750 ? 40 : 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.purple,
          ),
          child: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
