import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yonesto_ui/models/buy_request.dart'; // Asegúrate de importar tus modelos aquí

class ApiService {
  final String apiUrl = 'http://yonesto.pythonanywhere.com';
  final String version = "v1";
  final http.Client httpClient;

  ApiService(this.httpClient);

  Future<dynamic> getProducts() async {
    final response = await httpClient
        .get(Uri.parse('$apiUrl/api/$version/store/product/info'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<dynamic> getUsers() async {
    final response = await httpClient.get(Uri.parse('$apiUrl/users'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<dynamic> getPurchases() async {
    final response = await httpClient.get(Uri.parse('$apiUrl/purchases'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch purchases');
    }
  }

  Future<dynamic> createBuy(BuyRequest buyRequest) async {
    final response = await httpClient.post(
      Uri.parse('$apiUrl/api/$version/store/buy/create/'),
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
