import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:yonesto_ui/models/buy_request.dart';
import 'package:yonesto_ui/models/product_response.dart';
import 'package:yonesto_ui/service/apis/yonesto/base.dart';
import 'package:yonesto_ui/service/data_static.dart'; // Asegúrate de importar tus modelos aquí

class YonestoAPI {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token ${dotenv.env['YONESTO_API_KEY']}',
  };
  YonestoAPI();
  Future<bool> getProducts() async {
    // Make Request
    var uri = Uri.parse('${YonestoBase.url}/product/info');
    var response = await http.get(uri);

    // Check Status Code
    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      Map<String, dynamic> responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var productsResponse = ProductsResponse.fromJson(responseData);
      var success = productsResponse.success;

      // Load Data
      if (success) {
        databaseStatic.products.clear();
        databaseStatic.products = productsResponse.data;
      }

      return Future(() => success);
    }

    return Future(() => false);
  }

  Future<bool> createBuy(BuyRequest buyRequest) async {
    try {
      final response = await http.post(
        Uri.parse('${YonestoBase.url}/buy/create/'),
        body: jsonEncode(buyRequest.toJson()),
        headers: headers,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return true;
  }
}
