import 'package:flutter/material.dart';
import 'package:unicapp/core/yonesto/models/product.dart';
import 'package:unicapp/ui/molecules/cards/shop.dart';

class InfoProductAlertDialog extends StatelessWidget {
  const InfoProductAlertDialog({
    super.key,
    required this.product,
    required this.index,
  });

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ShoppingCard(
        product: product,
        index: index,
        height: 400,
        width: 400,
        imageHeight: 250,
      ),
    );
  }
}
