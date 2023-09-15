import 'package:yonesto_ui/models/product.dart';

class ProductsResponse {
  bool success;
  String? message;
  List<Product> data;

  ProductsResponse({
    required this.success,
    this.message,
    required this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> map) {
    return ProductsResponse(
      success: map['Success'],
      message: map['Message'],
      data: List<Product>.from(map['Data']?.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Success': success,
      'Message': message,
      'Data': data.map((product) => product.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ProductsResponse(success: $success, message: $message, data: $data)';
  }
}
