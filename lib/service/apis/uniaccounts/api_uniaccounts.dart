//import 'package:http/http.dart' as http;
//import 'package:yonesto_ui/service/apis/uniaccounts/base.dart' as BASE;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:yonesto_ui/models/user.dart';
import 'package:yonesto_ui/service/apis/uniaccounts/base.dart';
import 'package:yonesto_ui/service/data_static.dart';

class AccountAPI {
  Future<bool> signUp(User user) async {
    /*
    var url = Uri.parse('${BASE.URL_API}/api/v1/signup');
    var body = jsonEncode(user.toJson());
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      print(responseData);

      return Future(() => success);
    }
    */
    return Future(() => false);
  }

  Future<int> signIn(User user) async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Api-Key': dotenv.env['API_KEY'] ?? '',
        'Service': dotenv.env['SERVICE_NAME'] ?? '',
      };
      final String body = jsonEncode({
        "user_name": user.userName,
        "password": user.password,
      });
      final http.Response response = await http.put(
        Uri.parse('${UniaccountsBase.url}/signin'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        final bool success = responseData['Success'];
        if (success) {
          databaseStatic.jwt = responseData['Data']['token_jwt'];
          databaseStatic.userName = user.userName;
        }
      }

      return response.statusCode;
    } catch (e) {
      print('Error en la solicitud: $e');
      return -1; // Devuelve un valor negativo para indicar un error
    }
  }
}
