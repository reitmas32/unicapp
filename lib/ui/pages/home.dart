import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yonesto_ui/ui/widgets/awesom_button.dart';
import 'package:yonesto_ui/ui/widgets/theme_button.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/product.dart';
import 'package:yonesto_ui/providers/cart.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';
import 'package:yonesto_ui/service/data_static.dart';
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
      displayProducts = mainProdcuts!
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    mainProdcuts = [];
    displayProducts = List.from(mainProdcuts ?? []);
    cartProdicts = [];
    getProducts();
  }

  bool dataIsReady = false;

  Future<void> getProducts() async {
    final response = await yonestoAPI.getProducts();
    if (response) {
      setState(() {
        mainProdcuts = databaseStatic.products;
        displayProducts = mainProdcuts ?? [];
        dataIsReady = true;
      });
    }
  }

  List<Product>? mainProdcuts;
  List<Product> displayProducts = [];
  List<Product> cartProdicts = [];
  @override
  Widget build(BuildContext context) {
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
      drawer: const YonestoDrawer(),
      appBar: YonestoAppBar(
        title: SearchBar(
          onChanged: updateProducts,
        ),
      ),
      body: !dataIsReady
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : ContentShop(
              displayProducts: displayProducts,
            ),
    );
  }
}

class YonestoDrawer extends StatelessWidget {
  const YonestoDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
            ),
            child: Text(
              'UNICapp',
              style: GoogleFonts.righteous(
                fontSize: 35,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: AwesomButton(
              lable: 'Pay debts',
              onTap: () {},
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const ThemeButton(),
              AwesomButton(
                lable: 'Sign Out',
                onTap: () async {
                  if (await StorageConection.cleanJWT()) {
                    // ignore: use_build_context_synchronously
                    context.go('/');
                  }
                },
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
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
              WrapProducts(
                displayProducts: displayProducts,
              ),
              ListOfCart(
                displayProducts: cart.getCart(),
              )
            ],
          )
        : WrapProducts(
            displayProducts: displayProducts,
          );
  }
}
