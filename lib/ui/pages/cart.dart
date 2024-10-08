import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yonesto_ui/domain/models/product/product.dart';
import 'package:yonesto_ui/providers/cart.dart';
import 'package:yonesto_ui/ui/views/yonesto/cart_products.dart';
import 'package:yonesto_ui/ui/views/common/app_bar.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  void updateProducts(String value) {
    setState(() {
      displayProducts = cartProducts
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  List<Product> displayProducts = [];
  List<Product> cartProducts = [];
  bool firstShow = false;

  @override
  initState() {
    super.initState();
  }

  bool compareLists(List<dynamic> list1, List<dynamic> list2) {
    bool allElementsPresent = list2.every((element) => list1.contains(element));
    bool containsExtraElement =
        list2.any((element) => !list1.contains(element));

    return allElementsPresent && !containsExtraElement;
  }

  List<Product> cartProdicts = [];

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: MinimalistAppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: Column(
        children: [
          CartProducts(
            displayProducts: cart,
          ),
        ],
      ),
    );
  }
}
