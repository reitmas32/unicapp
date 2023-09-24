import 'package:unicapp/core/yonesto/models/product_request.dart';

class BuyRequest {
  int clientCode;
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
