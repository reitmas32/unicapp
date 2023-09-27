import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:unicapp/shared/models/proccess_response.dart';
import 'package:unicapp/core/uniaccounts/models/user_getway.dart';
import 'package:unicapp/core/uniaccounts/models/signin_response.dart';
import 'package:unicapp/core/uniaccounts/models/user.dart';
import 'package:unicapp/core/api_conection.dart';
import 'package:unicapp/core/uniaccounts/services/base.dart';

class AccountAPI extends AccontsUserAPI {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Api-Key': uniaccountsBase.apiKey,
    'Service': uniaccountsBase.serviceName,
  };

  AccountAPI({required super.storage});

  Future<bool> signUp(User user) async {
    return Future(() => false);
  }

  @override
  Future<ProccessResponce> singIn(User user) async {
    var responseProccess = ProccessResponce(
      success: false,
      data: '',
      code: 500,
    );
    try {
      // Create Body by Request
      final String bodyRequestSignIn = jsonEncode({
        "user_name": user.userName,
        "password": user.password,
      });

      // Make the Request
      final http.Response response = await http.put(
        Uri.parse('${uniaccountsBase.url}/signin'),
        headers: headers,
        body: bodyRequestSignIn,
      );

      // Proccess if THe Request is Successfull
      if (response.statusCode == 200) {
        // Decode Response
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Get Data
        final SignInResponse signInResponse =
            SignInResponse.fromJson(responseData);
        if (signInResponse.success) {
          user.jwt = signInResponse.jwt!;
          await storage.saveJWT(signInResponse.jwt!);
          await storage.saveUserName(user.userName);
          responseProccess.data = signInResponse;

          responseProccess.success = signInResponse.success;

          yonestoAPI.storage.saveCode(decodeCode(user.password));
        }
        responseProccess.code = response.statusCode;
      }
    } on Exception catch (e) {
      responseProccess.data = e.toString();
    }

    return Future(() => responseProccess);
  }

  String decodeCode(String password) {
    String code_0 = AccountAPI.hash[password[0]] ?? '';
    String code_1 = AccountAPI.hash[password[1]] ?? '';
    String code_2 = AccountAPI.hash[password[2]] ?? '';
    String code_3 = AccountAPI.hash[password[3]] ?? '';
    String code_4 = AccountAPI.hash[password[4]] ?? '';

    String code = code_0 + code_1 + code_2 + code_3 + code_4;

    return code;
  }

  static const Map<String, String> hash = {
    'k': '1',
    'm': '7',
    'n': '6',
    'r': '9',
    'p': '3',
    'l': '4',
    'w': '0',
    'x': '5',
    'y': '2',
    'z': '8',
  };
}
