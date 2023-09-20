import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:yonesto_ui/domain/models/proccess_response/proccess_response.dart';
import 'package:yonesto_ui/domain/models/user/user_getway.dart';
import 'package:yonesto_ui/models/signin_response.dart';
import 'package:yonesto_ui/domain/models/user/user.dart';
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
        Uri.parse('${UniaccountsBase.url}/signin'),
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
        }
        responseProccess.code = response.statusCode;
      }
    } on Exception catch (e) {
      responseProccess.data = e.toString();
    }

    return Future(() => responseProccess);
  }
}
