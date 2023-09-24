import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicapp/core/yonesto/models/product.dart';
import 'package:unicapp/models/buy_request.dart';
import 'package:unicapp/models/product_request.dart';
import 'package:unicapp/providers/shop.dart';
import 'package:unicapp/core/api_conection.dart';
import 'package:unicapp/shared/tools/tools.dart';

class Cart extends StateNotifier<List<Product>> {
  // We initialize the list of todos to an empty list
  Cart() : super([]);

  bool add(List<Product> shop, Product product) {
//Load Shop

    final constaint2List =
        indexWher2List<Product>(shop, state, (item) => item.id == product.id);

    if (constaint2List < -1) {
      return false;
    }

    if (constaint2List != -1) {
      // El producto ya está en el carrito, aumenta la cantidad en stock
      state[constaint2List].stock++;
      state = [...state];
    } else {
      // Nuevo Producto

      state = [
        ...state,
        Product(
          id: product.id,
          name: product.name,
          stock: 1,
          code: product.code,
          image: product.image,
          salePrice: product.salePrice,
          purchasePrice: product.purchasePrice,
          product: product.product,
          quantity: product.quantity,
          selected: product.selected,
        )
      ];
    }
    return true;
  }

  bool remove(Product product) {
    int productIndex = state.indexWhere((item) => item.id == product.id);
    if (productIndex != -1) {
      // El producto ya está en el carrito, aumenta la cantidad en stock
      if (state[productIndex].stock > 1) {
        state[productIndex].stock--;
      } else {
        state.removeWhere((element) => element.id == product.id);
      }
      state = [...state];
    }

    return true;
  }

  bool delete(Product product) {
    state.removeWhere((element) => element.id == product.id);
    return true;
  }

  bool clear() {
    state.clear();
    return true;
  }

  Future<bool> createBuy(int code, double payment) async {
    BuyRequest buyRequest = BuyRequest(
        clientCode: code,
        payment: payment,
        products: state
            .map((product) => ProductRequest(
                  product: product.id,
                  quantity: product.stock,
                ))
            .toList());

    var responseCreateBuy = await yonestoAPI.createBuy(buyRequest);
    if (responseCreateBuy.success) {
      state = [];
    }
    return responseCreateBuy.success;
  }

  int getTotalProducts() {
    return state.length;
  }
}

final cartProvider = StateNotifierProvider<Cart, List<Product>>((ref) {
  return Cart();
});

final createBuy = FutureProvider.family
    .autoDispose<bool, BuyRequest>((ref, buyRequest) async {
  final shopProducts = await ref
      .watch(cartProvider.notifier)
      .createBuy(buyRequest.clientCode, buyRequest.payment);
  return shopProducts;
});

final getTotalProducts = Provider.autoDispose<int>((ref) {
  final cart = ref.watch(cartProvider);
  int len = 0;
  for (var p in cart) {
    len += p.stock;
  }
  return len;
});

final deleteToCart = Provider.family<void, Product>((ref, product) {
  ref.read(shopProvider.notifier).resetStock(product);
  ref.read(cartProvider.notifier).delete(product);
});
