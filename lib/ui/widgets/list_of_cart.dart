// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/providers/cart.dart';
import 'package:unihacks_ui_kit/buttons/action_button.dart';
import 'package:unihacks_ui_kit/text_fields/multiple_textfields.dart';

class ListOfCart extends StatelessWidget {
  const ListOfCart({
    super.key,
    required this.displayProducts,
  });

  final List<Product> displayProducts;

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
                return CardProductCart(
                  product: displayProducts[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Lógica para la acción del botón
                print('¡Compra finalizada!');
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

class CardProductCart extends StatelessWidget {
  CardProductCart({
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

class CompletePurchaseDialog extends StatefulWidget {
  CompletePurchaseDialog({super.key});

  @override
  State<CompletePurchaseDialog> createState() => _CompletePurchaseDialogState();
}

class _CompletePurchaseDialogState extends State<CompletePurchaseDialog> {
  TextEditingController idUserController = TextEditingController();

  TextEditingController paymentController = TextEditingController();
  String payment = '0.0';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final currentColor = Provider.of<ThemeProvider>(context);
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MultipleTextField(
            lable: 'ID Usuario',
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            autofocus: true,
            textEditingController: idUserController,
          ),
          MultipleTextField(
            lable: 'Cunato Pagaras',
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            onlyNumbers: true,
            onChanged: (text) {
              setState(() {
                if (text == '') {
                  payment = '0.0';
                } else {
                  payment = text;
                }
              });
            },
            textEditingController: paymentController,
          ),
          Text(
              'Tu deuda Aumentara en: ${cart.calculateTotal() - double.parse(payment)}'),
        ],
      ),
      actions: <Widget>[
        ActionButton(
          onTap: () {
            Navigator.pop(context);
            cart.cleanCart();
            var snackBar = SnackBar(
              content: Text(
                '¡Disfruta tu compra!',
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
          lable: 'Finalizar',
          color: Colors.purple,
        ),
      ],
    );
  }
}
