class BuyRequest {
  dynamic clientCode;
  double payment;
  List<ProductRequest> products;

  BuyRequest({
    required this.clientCode,
    required this.payment,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'client_code': clientCode,
      'payment': payment,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'BuyRequest(clientCode: $clientCode, payment: $payment, products: $products)';
  }

  factory BuyRequest.fromMap(Map<String, dynamic> map) {
    return BuyRequest(
      clientCode: map['client_code'],
      payment: map['payment'],
      products: List<ProductRequest>.from(
          map['products']?.map((x) => ProductRequest.fromMap(x))),
    );
  }
}

class ProductRequest {
  String? product;
  int? quantity;

  ProductRequest({
    this.product,
    this.quantity,
  });

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

  factory ProductRequest.fromMap(Map<String, dynamic> map) {
    return ProductRequest(
      product: map['product'],
      quantity: map['quantity'],
    );
  }
}
