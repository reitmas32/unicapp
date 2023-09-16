import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yonesto_ui/models/buy_request.dart';
import 'package:yonesto_ui/models/product_response.dart';
import 'package:yonesto_ui/service/apis/yonesto/base.dart';
import 'package:yonesto_ui/service/data_static.dart'; // Asegúrate de importar tus modelos aquí

class YonestoAPI {
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

  Future<dynamic> createBuy(BuyRequest buyRequest) async {
    final response = await http.post(
      Uri.parse('${YonestoBase.url}/buy/create/'),
      body: jsonEncode(buyRequest.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create buy');
    }
  }
}
