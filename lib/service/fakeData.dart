import 'package:yonesto_ui/models/product.dart';

List<Product> generateFakeProducts(int count) {
  List<Product> fakeProducts = [];

  for (int i = 0; i < count; i++) {
    fakeProducts.add(Product(
      id: 'id_$i',
      product: 'Product $i',
      code: 'code_$i',
      name: 'Name $i',
      stock: 50 + i,
      purchasePrice: 10.0 + i.toDouble(),
      salePrice: 15.0 + i.toDouble(),
      image:
          'https://www.generaldistributionlc.com/cdn/shop/products/Sabritas-Chetos-Flaming-150gr.png?v=1558976038',
      selected: i.isEven,
      quantity: i % 3,
    ));
  }

  return fakeProducts;
}

List<Product> fakeProducts = generateFakeProducts(30);
