import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yonesto_ui/domain/models/product/product.dart';
import 'package:yonesto_ui/providers/shop.dart';
import 'package:yonesto_ui/tools/tools.dart';

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
    } else {
      // Nuevo Producto

      state.add(Product(
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
      ));
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
    }

    return true;
  }

  bool delete(Product product) {
    state.removeWhere((element) => element.id == product.id);
    return true;
  }
}

final cartProvider = StateNotifierProvider<Cart, List<Product>>((ref) {
  return Cart();
});
