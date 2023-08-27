import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/providers/cart.dart';
import 'package:yonesto_ui/service/fakeData.dart';
import 'package:yonesto_ui/ui/widgets/list_of_cart.dart';
import 'package:yonesto_ui/ui/widgets/wrap_products.dart';
import 'package:yonesto_ui/ui/widgets/yonesto_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateProducts(String value) {
    setState(() {
      displayProducts = mainProdcuts
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  static List<Product> mainProdcuts = generateFakeProducts(11);
  List<Product> displayProducts = List.from(mainProdcuts);
  List<Product> cartProdicts = [];
  @override
  Widget build(BuildContext context) {
    final currentColor = Provider.of<ThemeProvider>(context);
    final cart = Provider.of<CartProvider>(context);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: size.width < 750
          ? FloatingActionButton(
              onPressed: () {
                context.go('/cart');
              },
              backgroundColor: Colors.purple,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            )
          : null,
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
      body: Row(
        children: [
          WrapProducts(
            displayProducts: displayProducts,
          ),
          size.width > 750
              ? ListOfCart(
                  displayProducts: cart.getCart(),
                )
              : Container(),
        ],
      ),
    );
  }
}
