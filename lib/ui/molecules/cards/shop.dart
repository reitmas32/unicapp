import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicapp/core/yonesto/models/product.dart';
import 'package:unicapp/apps/yonesto/providers/providers.dart';
import 'package:unicapp/ui/molecules/package.dart';

class ShoppingCard extends ConsumerStatefulWidget {
  ShoppingCard({
    super.key,
    required this.index,
    required this.product,
  });

  final int index;
  final Product product;
  final List<bool> starStates = [true, true, true, false, false];

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ShoppingCardState();
}

class ShoppingCardState extends ConsumerState<ShoppingCard> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    final size = MediaQuery.of(context).size;
    return Card(
      color: widget.product.stock == 0
          ? const Color.fromARGB(53, 228, 44, 31)
          : isDarkMode
              ? const Color.fromARGB(255, 35, 34, 34)
              : const Color.fromARGB(255, 199, 197, 197),
      elevation: widget.product.stock == 0 ? 0 : 15.0,
      shadowColor: Colors.purple,
      child: Container(
        width: size.width > 750 ? 200 : 120,
        height: 200,
        padding: EdgeInsets.all(size.width > 750 ? 20 : 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Image.network(
                //'https://www.generaldistributionlc.com/cdn/shop/products/Sabritas-Chetos-Flaming-150gr.png?v=1558976038',
                widget.product.image,
                height: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                widget.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  //fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  widget.starStates[index] ? Icons.star : Icons.star_border,
                  color: Colors.purple,
                  size: 15,
                ),
              ),
            ),
            Text('${widget.product.stock} Unidades'),
            Row(
              children: [
                Text('\$${widget.product.salePrice}'),
                const Spacer(),
                UpdateCartButton(
                  onTap: removeToCart,
                  iconData: Icons.remove,
                  avalible: true,
                ),
                UpdateCartButton(
                  onTap: addToCart,
                  iconData: Icons.add,
                  avalible: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void removeToCart() {
    setState(() {
      ref.read(shopProvider.notifier).incrementStock(widget.product);
      ref.read(cartProvider.notifier).remove(widget.product);
    });
  }

  void addToCart() {
    setState(() {
      final shop = ref.read(shopProvider.notifier);
      final res =
          ref.read(shopProvider.notifier).decrementStock(widget.product);
      if (!res) return;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      ref.read(cartProvider.notifier).add(shop.state, widget.product);
    });
  }
}
