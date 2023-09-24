import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:yonesto_ui/domain/models/proccess_response/proccess_response.dart';
import 'package:yonesto_ui/domain/models/user/user_getway.dart';
import 'package:yonesto_ui/models/signin_response.dart';
import 'package:yonesto_ui/domain/models/user/user.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';
import 'package:yonesto_ui/service/apis/uniaccounts/base.dart';

class AccountAPI extends AccontsUserAPI {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Api-Key': dotenv.env['UNIACCONTS_API_KEY'] ?? '',
    'Service': dotenv.env['SERVICE_NAME'] ?? '',
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
    String code_1 = AccountAPI.hash[password[2]] ?? '';
    String code_2 = AccountAPI.hash[password[4]] ?? '';
    String code_3 = AccountAPI.hash[password[6]] ?? '';
    String code_4 = AccountAPI.hash[password[8]] ?? '';

    String code = code_0 + code_1 + code_2 + code_3 + code_4;

    return code;
  }

  static const Map<String, String> hash = {
    'a': '0',
    'b': '1',
    'c': '2',
    'd': '3',
    'e': '4',
    'f': '5',
    'g': '6',
    'h': '7',
    'i': '8',
    'j': '9',
  };
}
