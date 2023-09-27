import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unicapp/shared/models/proccess_response.dart';
import 'package:unicapp/core/yonesto/models/yonesto_getway.dart';
import 'package:unicapp/core/yonesto/models/buy_request.dart';
import 'package:unicapp/core/yonesto/models/product_response.dart';
import 'package:unicapp/core/yonesto/services/base.dart';

class YonestoAPI extends YonestoAPIGetWay {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token ${yonestoBase.apiKey}',
  };
  YonestoAPI({required super.storage});

  @override
  Future<ProccessResponce> createBuy(BuyRequest buyRequest) async {
    var responsesProccess = ProccessResponce(
      success: false,
      data: [],
      code: 500,
    );
    try {
      final response = await http.post(
        Uri.parse('${yonestoBase.url}/buy/create/'),
        body: jsonEncode(buyRequest.toJson()),
        headers: headers,
      );

      if (response.statusCode == 201) {
        responsesProccess.success = true;
      }
      responsesProccess.code = response.statusCode;
      responsesProccess.data = jsonDecode(response.body);
    } on Exception catch (e) {
      responsesProccess.data = e.toString();
    }
    return responsesProccess;
  }

  @override
  Future<ProccessResponce> getDebts(int code) async {
    print(yonestoBase.apiKey);
    print(yonestoBase.url);
    var responsesProccess = ProccessResponce(
      success: false,
      data: [],
      code: 500,
    );
    try {
      final response = await http.get(
        Uri.parse('${yonestoBase.url}/users/unpaid-buys/$code'),
        headers: headers,
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        responsesProccess.success = true;
        responsesProccess.data = {
          'numberBuys': responseData['Data']?['number_buys'].toInt(),
          'totalRemainingAmount': responseData['Data']
              ?['total_remaining_amount']
        };
      }
    } on Exception catch (e) {
      responsesProccess.data = e.toString();
    }
    return responsesProccess;
  }

  @override
  Future<ProccessResponce> getProducts() async {
    var responsesProccess = ProccessResponce(
      success: false,
      data: [],
      code: 500,
    );
    try {
      // Make Request
      var uri = Uri.parse('${yonestoBase.url}/product/info');
      var response = await http.get(uri);

      // Check Status Code
      if (response.statusCode == 200) {
        // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Acceder a los datos específicos dentro del objeto responseData
        var productsResponse = ProductsResponse.fromJson(responseData);

        responsesProccess.success = productsResponse.success;
        responsesProccess.code = response.statusCode;
        responsesProccess.data = productsResponse.data;
      }
    } on Exception catch (e) {
      responsesProccess.data = e.toString();
    }
    return responsesProccess;
  }

  @override
  Future<ProccessResponce> payDebts(int code, double pay) async {
    print(yonestoBase.apiKey);
    print(yonestoBase.url);
    var responsesProccess = ProccessResponce(
      success: false,
      data: [],
      code: 500,
    );
    try {
      final response = await http.post(
        Uri.parse('${yonestoBase.url}/users/pay-buys'),
        body: jsonEncode({
          'code': code,
          'payment': pay,
        }),
        headers: headers,
      );
      if (response.statusCode == 200) {
        responsesProccess.success = true;
      }
      responsesProccess.data = jsonDecode(response.body);
    } on Exception catch (e) {
      responsesProccess.data = e.toString();
    }

    return responsesProccess;
  }
}
