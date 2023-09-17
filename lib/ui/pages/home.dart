import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yonesto_ui/ui/views/common/drawer.dart';
import 'package:yonesto_ui/ui/views/yonesto/cart_products.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/providers/cart.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';
import 'package:yonesto_ui/service/data_static.dart';
import 'package:yonesto_ui/ui/views/yonesto/shop_products.dart';
import 'package:yonesto_ui/ui/views/common/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  bool dataIsReady = false;

  Future<void> getProducts() async {
    if (databaseStatic.products.isEmpty) {
      await yonestoAPI.getProducts();
    }
    //if (response) {
    setState(() {
      dataIsReady = true;
    });
    //}
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);
    if (cart.shop.isEmpty) {
      cart.loadShop(databaseStatic.products);
    }
    return Scaffold(
      floatingActionButton: size.width < 750
          ? Stack(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.go('/cart');
                  },
                  backgroundColor: Colors.purple,
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
                if (cart.quanty != 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(
                            milliseconds: 500), // Duración de la animación
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          cart.quanty.toString(),
                          key: ValueKey<int>(cart
                              .quanty), // Identificar el widget para la animación
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )
          : null,
      drawer: const YonestoDrawer(),
      appBar: UNICappAppBar(
        title: SearchBar(
          onChanged: cart.updateDisplay,
        ),
      ),
      body: !dataIsReady
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : ContentShop(
              displayProducts: cart.display,
            ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final currentColor = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: currentColor.isDarkTheme()
              ? const Color.fromARGB(255, 35, 34, 34)
              : const Color.fromARGB(255, 199, 197, 197),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          hintText: "eg: CocaCola",
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}

class ContentShop extends StatelessWidget {
  const ContentShop({super.key, required this.displayProducts});

  final List<Product> displayProducts;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final size = MediaQuery.of(context).size;
    return size.width > 750
        ? Row(
            children: [
              ShopProducts(
                displayProducts: displayProducts,
              ),
              CartProducts(
                displayProducts: cart.getCart(),
              )
            ],
          )
        : ShopProducts(
            displayProducts: displayProducts,
          );
  }
}
