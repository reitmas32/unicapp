import 'package:flutter/material.dart';
import 'package:yonesto_ui/models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> cart = [];

  addToCart(Product product) {
    int productIndex = cart.indexWhere((item) => item.id == product.id);

    if (productIndex != -1) {
      // El producto ya está en el carrito, aumenta la cantidad en stock
      cart[productIndex].stock++;
    } else {
      // Agrega el producto al carrito si no estaba en él
      cart.add(Product(
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

    notifyListeners();
  }

  removeToCart(Product product) {
    int productIndex = cart.indexWhere((item) => item.id == product.id);

    if (productIndex != -1) {
      // El producto ya está en el carrito, aumenta la cantidad en stock
      if (cart[productIndex].stock > 1) {
        cart[productIndex].stock--;
      } else {
        cart.removeWhere((element) => element.id == product.id);
      }
    }

    notifyListeners();
  }

  deleteToCart(Product product) {
    cart.removeWhere((element) => element.id == product.id);

    notifyListeners();
  }

  cleanCart() {
    cart.clear();
    notifyListeners();
  }

  double calculateTotal() {
    double total = 0;

    for (var product in cart) {
      total += product.stock * product.salePrice;
    }

    return total;
  }

  List<Product> getCart() {
    return cart;
  }
}
