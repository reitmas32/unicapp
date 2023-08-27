import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({super.key});

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  bool isHoverShoppingCart = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          context.go('/cart');
        },
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              isHoverShoppingCart = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHoverShoppingCart = false;
            });
          },
          child: Icon(
            Icons.shopping_cart,
            size: 30,
            color: isHoverShoppingCart
                ? Colors.purple
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
