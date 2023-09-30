import 'package:flutter/material.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unicapp/apps/yonesto/providers/providers.dart';
import '../views/common/drawer.dart';
import 'package:unicapp/core/yonesto/models/product.dart';

import '../views/yonesto/shop_products.dart';
import '../views/common/app_bar.dart';
import '../widgets/molecules/appbar.dart';

import 'dart:io' show Platform;

class YonestoShopPage extends ConsumerStatefulWidget {
  const YonestoShopPage({super.key});

  @override
  ConsumerState<YonestoShopPage> createState() => _YonestoShopPageState();
}

class _YonestoShopPageState extends ConsumerState<YonestoShopPage> {
  @override
  void initState() {
    super.initState();
  }

  String lable = '';
  @override
  Widget build(BuildContext context) {
    final displayProducts = ref.watch(filterCartProvider(lable));
    final int len = ref.watch(getTotalProducts);
    return Scaffold(
      floatingActionButton: !Platform.isWindows
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
                if (len != 0)
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
                          len.toString(), // Identificar el widget para la animación
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
        title: YonestoSearchBar(
          onChanged: (value) {
            setState(() {
              lable = value;
            });
          },
        ),
      ),
      body: displayProducts.when(
        data: (data) => ContentShop(displayProducts: data),
        error: (err, __) => Center(child: Text('Error: $err')),
        loading: () => const Center(
          child: FourCirclePulse(
            circleColor: Colors.purple, //The color of the circles
            dimension: 100, // The size of the widget.
            turns: 3, //Turns in each loop
            loopDuration: Duration(
              milliseconds: 800,
            ), // Duration of each loop
            curve: Curves.linear, //Curve of the animation
          ),
        ),
      ),
    );
  }

  int totalProducts(List<Product> products) {
    int total = 0;
    for (var product in products) {
      total += product.stock;
    }
    setState(() {});
    return total;
  }
}

class ContentShop extends StatelessWidget {
  const ContentShop({super.key, required this.displayProducts});

  final List<Product> displayProducts;

  @override
  Widget build(BuildContext context) {
    return ShopProducts(
      displayProducts: displayProducts,
    );
  }
}
