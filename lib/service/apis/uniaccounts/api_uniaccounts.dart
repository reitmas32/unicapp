import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:yonesto_ui/models/signin_response.dart';
import 'package:yonesto_ui/models/user.dart';
import 'package:yonesto_ui/service/apis/uniaccounts/base.dart';
import 'package:yonesto_ui/service/data_static.dart';

class AccountAPI {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Api-Key': dotenv.env['UNIACCONTS_API_KEY'] ?? '',
    'Service': dotenv.env['SERVICE_NAME'] ?? '',
  };

  Future<bool> signUp(User user) async {
    return Future(() => false);
  }

  Future<int> signIn(User user) async {
    try {
      final String bodyRequestSignIn = jsonEncode({
        "user_name": user.userName,
        "password": user.password,
      });
      final http.Response response = await http.put(
        Uri.parse('${UniaccountsBase.url}/signin'),
        headers: headers,
        body: bodyRequestSignIn,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        final SignInResponse signInResponse =
            SignInResponse.fromJson(responseData);

        final bool success = signInResponse.success;
        if (success) {
          databaseStatic.jwt = responseData['Data']['token_jwt'];
          databaseStatic.userName = user.userName;
          StorageConection.writeJWT(databaseStatic.jwt);
          String code = StorageConection.decodeCode(user.password);
          StorageConection.writeCode(code.toString());
        }
      }

      return response.statusCode;
    } catch (e) {
      if (kDebugMode) {
        print('Error en la solicitud: $e');
      }
      return -1; // Devuelve un valor negativo para indicar un error
    }
  }
}
