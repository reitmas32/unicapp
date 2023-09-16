import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/providers/cart.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    required this.avalible,
  });

  final Product product;
  final bool avalible;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: avalible
          ? () {
              cart.addToCart(product);
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: size.width > 750 ? 40 : 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: avalible ? Colors.purple : Color.fromARGB(255, 101, 69, 107),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
