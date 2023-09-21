import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yonesto_ui/domain/models/product/product.dart';
import 'package:yonesto_ui/providers/providers.dart';

class CartCard extends ConsumerStatefulWidget {
  CartCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  final Product product;
  final List<bool> starStates = [true, true, true, false, false];
  final VoidCallback onDelete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CartCardState();
}

class CartCardState extends ConsumerState<CartCard> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Card(
      color: isDarkMode
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
                      widget.product.name,
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
                        widget.starStates[index]
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.purple,
                        size: 15,
                      ),
                    ),
                  ),
                  Text('${widget.product.stock} Unidades'),
                  Row(
                    children: [
                      Text('\$${widget.product.salePrice}'),
                    ],
                  )
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  widget.onDelete();
                  var snackBar = SnackBar(
                    content: Text(
                      '¡Se Eliminaron todos los ${widget.product.name} del Carrito!',
                      style: TextStyle(
                        color: isDarkMode
                            ? const Color.fromARGB(255, 199, 197, 197)
                            : const Color.fromARGB(255, 35, 34, 34),
                      ),
                    ),
                    duration: const Duration(milliseconds: 750),
                    backgroundColor: isDarkMode
                        ? const Color.fromARGB(255, 35, 34, 34)
                        : const Color.fromARGB(
                            255, 199, 197, 197), // Duración de la visibilidad
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
