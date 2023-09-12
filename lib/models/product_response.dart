import 'package:yonesto_ui/models/product.dart';

class ProductResponse {
  bool success;
  String? message;
  List<Product> data;

  ProductResponse({
    required this.success,
    this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> map) {
    return ProductResponse(
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
    return 'ProductResponse(success: $success, message: $message, data: $data)';
  }
}
