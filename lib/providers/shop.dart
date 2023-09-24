import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicapp/domain/models/product/product.dart';
import 'package:unicapp/core/uniaccounts/services/api_conection.dart';

class Shop extends StateNotifier<List<Product>> {
  // We initialize the list of todos to an empty list
  Shop() : super([]);

  List<Product> originalShop = [];

  Future<List<Product>> load() async {
    if (state.isEmpty) {
      final response = await yonestoAPI.getProducts();
      if (response.success) {
        state = response.data;

        for (var p in state) {
          originalShop.add(
            Product(
                id: p.id,
                code: p.code,
                name: p.name,
                stock: p.stock,
                purchasePrice: p.purchasePrice,
                salePrice: p.salePrice,
                image: p.image),
          );
        }
      } else {
        throw const FormatException('Error al cargar los Productos');
      }
    }
    return Future(() => state);
  }

  bool incrementStock(Product product) {
    Product originalProduct =
        originalShop.where((element) => element.id == product.id).first;
    if (kDebugMode) {
      print('Original Stock: ${originalProduct.stock}');
      print('Current Stock: ${product.stock}');
    }

    if (product.stock < originalProduct.stock) {
      int productShopIndex = state.indexWhere((item) => item.id == product.id);
      state[productShopIndex].stock++;
    }

    return true;
  }

  bool decrementStock(Product product) {
    int productShopIndex = state.indexWhere((item) => item.id == product.id);
    if (state[productShopIndex].stock == 0) {
      return false;
    }
    state[productShopIndex].stock--;
    return true;
  }

  bool resetStock(Product product) {
    Product originalProduct =
        originalShop.where((element) => element.id == product.id).first;
    int indexProduct = state.indexWhere((element) => element.id == product.id);

    if (indexProduct != -1) {
      state[indexProduct].stock = originalProduct.stock;
    }
    return true;
  }
}

final shopProvider = StateNotifierProvider<Shop, List<Product>>((ref) {
  return Shop();
});

final filterCartProvider =
    FutureProvider.family<List<Product>, String>((ref, lable) async {
  final shopProducts = await ref.watch(shopProvider.notifier).load();
  final List<Product> products = shopProducts;
  return products
      .where(
          (element) => element.name.toLowerCase().contains(lable.toLowerCase()))
      .toList();
});
