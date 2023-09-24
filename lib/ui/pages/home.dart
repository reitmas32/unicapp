import 'package:flutter/material.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unicapp/providers/providers.dart';
import 'package:unicapp/ui/views/common/drawer.dart';
import 'package:unicapp/domain/models/product/product.dart';

import 'package:unicapp/ui/views/yonesto/shop_products.dart';
import 'package:unicapp/ui/views/common/app_bar.dart';
import 'package:unicapp/ui/widgets/molecules/appbar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  String lable = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final displayProducts = ref.watch(filterCartProvider(lable));
    final int len = ref.watch(getTotalProducts);
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
