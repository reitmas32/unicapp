import 'package:flutter/material.dart';
import 'package:yonesto_ui/domain/models/product/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> cart = [];
  List<Product> shop = [];
  List<Product> display = [];
  int quanty = 0;

  addToCart(Product product) {
    int productCartIndex = cart.indexWhere((item) => item.id == product.id);
    int productShopIndex = shop.indexWhere((item) => item.id == product.id);
    if (productShopIndex == -1) {
      notifyListeners();
      return;
    }

    if (productCartIndex != -1) {
      // El producto ya está en el carrito, aumenta la cantidad en stock
      cart[productCartIndex].stock++;
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
    shop[productShopIndex].stock--;
    quanty++;

    notifyListeners();
  }

  removeToCart(Product product) {
    int productIndex = cart.indexWhere((item) => item.id == product.id);
    int productShopIndex = shop.indexWhere((item) => item.id == product.id);
    if (productShopIndex == -1) {
      notifyListeners();
      return;
    }
    if (productIndex != -1) {
      // El producto ya está en el carrito, aumenta la cantidad en stock
      if (cart[productIndex].stock > 1) {
        cart[productIndex].stock--;
      } else {
        cart.removeWhere((element) => element.id == product.id);
      }
      quanty--;
      shop[productShopIndex].stock++;
    }
    notifyListeners();
  }

  updateDisplay(String value) {
    display = shop
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    notifyListeners();
  }

  loadShop(List<Product> products) {
    shop = products;
    display = shop;
  }

  deleteToCart(Product product) {
    cart.removeWhere((element) => element.id == product.id);
    quanty -= product.stock;
    int productShopIndex = shop.indexWhere((item) => item.id == product.id);
    if (productShopIndex != -1) {
      shop[productShopIndex].stock += product.stock;
    }

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
