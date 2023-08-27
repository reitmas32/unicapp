import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/providers/cart.dart';
import 'package:yonesto_ui/ui/widgets/list_of_cart.dart';
import 'package:yonesto_ui/ui/widgets/yonesto_appbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
    final currentColor = Provider.of<ThemeProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    cartProducts = cart.getCart();
    if (!firstShow || !compareLists(cart.getCart(), displayProducts)) {
      displayProducts = List.from(cartProducts);
      firstShow = true;
    }

    return Scaffold(
      appBar: YonestoAppBar(
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: TextField(
            onChanged: (value) => updateProducts(value),
            decoration: InputDecoration(
              filled: true,
              fillColor: currentColor.isDarkTheme()
                  ? const Color.fromARGB(255, 35, 34, 34)
                  : const Color.fromARGB(255, 199, 197, 197),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              hintText: "eg: CocaCola",
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.purple,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          ListOfCart(
            displayProducts: displayProducts,
          ),
        ],
      ),
    );
  }
}
