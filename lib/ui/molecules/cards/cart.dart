import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yonesto_ui/domain/models/product/product.dart';
import 'package:yonesto_ui/providers/providers.dart';
import 'package:yonesto_ui/ui/atoms/package.dart';
import 'package:yonesto_ui/ui/molecules/buttons/delete_cart.dart';

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
      color: isDarkMode ? CustomColors.cardBgDark : CustomColors.cardBgLight,
      child: Padding(
        padding: Paddings.p200,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: Paddings.p200,
                child: Image.network(
                  widget.product.image,
                  height: 150,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: Paddings.pVertical200,
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
              DeleteCartButton(
                onTap: () {
                  widget.onDelete();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
