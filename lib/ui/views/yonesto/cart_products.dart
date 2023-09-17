import 'package:flutter/material.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/ui/views/diialogs/complete_purchase.dart';
import 'package:yonesto_ui/ui/widgets/cards/cart.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({
    super.key,
    required this.displayProducts,
  });

  final List<Product> displayProducts;

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
              itemCount: displayProducts.length,
              itemBuilder: (context, index) {
                return CartCard(
                  product: displayProducts[index],
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
                      return CompletePurchaseDialog();
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
