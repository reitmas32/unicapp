class Product {
  String? id;
  String? product;
  String code;
  String name;
  int stock;
  double purchasePrice;
  double salePrice;
  String image;
  bool? selected;
  int? quantity;

  Product({
    this.id,
    this.product,
    required this.code,
    required this.name,
    required this.stock,
    required this.purchasePrice,
    required this.salePrice,
    required this.image,
    this.selected,
    this.quantity,
  });

  // Implementación de copyWith
  Product copyWith({
    String? id,
    String? product,
    String? code,
    String? name,
    int? stock,
    double? purchasePrice,
    double? salePrice,
    String? image,
    bool? selected,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      product: product ?? this.product,
      code: code ?? this.code,
      name: name ?? this.name,
      stock: stock ?? this.stock,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salePrice: salePrice ?? this.salePrice,
      image: image ?? this.image,
      selected: selected ?? this.selected,
      quantity: quantity ?? this.quantity,
    );
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      product: map['product'],
      code: map['code'],
      name: map['name'],
      stock: map['stock'],
      purchasePrice: map['purchase_price'] ?? 0.0,
      salePrice: map['sale_price'],
      image: map['image'],
      selected: map['selected'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'code': code,
      'name': name,
      'stock': stock,
      'purchase_price': purchasePrice,
      'sale_price': salePrice,
      'image': image,
      'selected': selected,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, product: $product, code: $code, name: $name, stock: $stock, purchasePrice: $purchasePrice, salePrice: $salePrice, image: $image, selected: $selected, quantity: $quantity)';
  }
}
