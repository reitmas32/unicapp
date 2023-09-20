import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:yonesto_ui/domain/models/proccess_response/proccess_response.dart';
import 'package:yonesto_ui/domain/models/product/product.dart';
import 'package:yonesto_ui/domain/models/product/product_getway.dart';
import 'package:yonesto_ui/models/buy_request.dart';
import 'package:yonesto_ui/models/pay_debts_response.dart';
import 'package:yonesto_ui/models/product_response.dart';
import 'package:yonesto_ui/models/unpaid_buy_response.dart';
import 'package:yonesto_ui/service/apis/yonesto/base.dart';
import 'package:yonesto_ui/service/data_static.dart';

class YonestoAPI extends ProductsAPI {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token ${dotenv.env['YONESTO_API_KEY']}',
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
        Uri.parse('${YonestoBase.url}/buy/create/'),
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
    var responsesProccess = ProccessResponce(
      success: false,
      data: [],
      code: 500,
    );
    try {
      final response = await http.get(
        Uri.parse('${YonestoBase.url}/users/unpaid-buys/$code'),
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
      var uri = Uri.parse('${YonestoBase.url}/product/info');
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

        storage.saveCode('10064');
      }
    } on Exception catch (e) {
      responsesProccess.data = e.toString();
    }
    return responsesProccess;
  }

  @override
  Future<ProccessResponce> payDebts(int code, double pay) async {
    var responsesProccess = ProccessResponce(
      success: false,
      data: [],
      code: 500,
    );
    try {
      final response = await http.post(
        Uri.parse('${YonestoBase.url}/users/pay-buys'),
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
