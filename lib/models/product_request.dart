class ProductRequest {
  String? product;
  int? quantity;

  ProductRequest({
    this.product,
    this.quantity,
  });

  factory ProductRequest.fromMap(Map<String, dynamic> map) {
    return ProductRequest(
      product: map['product'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'ProductRequest(product: $product, quantity: $quantity)';
  }
}
