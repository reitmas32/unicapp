import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicapp/domain/models/product/product.dart';
import 'package:unicapp/providers/providers.dart';
import 'package:unicapp/ui/views/diialogs/complete_purchase.dart';
import 'package:unicapp/ui/molecules/package.dart';

class CartProducts extends ConsumerStatefulWidget {
  const CartProducts({
    super.key,
    required this.displayProducts,
  });

  final List<Product> displayProducts;

  @override
  ConsumerState<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends ConsumerState<CartProducts> {
  void showDelayedAlertDialog(BuildContext context, bool responseSuccess) {
    Future.delayed(const Duration(seconds: 2), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return responseSuccess
              ? const AlertDialog(
                  content: Text('Disfruta tu compra'),
                )
              : const AlertDialog(
                  content: Text('No se pudo realizar la compra'),
                );
        },
      );

      // Cerrar el AlertDialog después de 2 segundos
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.displayProducts.length,
              itemBuilder: (context, index) {
                return CartCard(
                  product: widget.displayProducts[index],
                  onDelete: () {
                    setState(() {
                      ref.read(deleteToCart(widget.displayProducts[index]));
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CompletePurchaseDialog(
                        cart: widget.displayProducts,
                      );
                    });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: const SizedBox(
                height: 50.0,
                child: Center(
                  child: Text(
                    'Finalizar Compra',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
