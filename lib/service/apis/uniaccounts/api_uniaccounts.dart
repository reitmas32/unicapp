//import 'package:http/http.dart' as http;
//import 'package:yonesto_ui/service/apis/uniaccounts/base.dart' as BASE;
import 'package:yonesto_ui/models/user.dart';

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

  Future<bool> signIn(User user) async {
    /*
    var url = Uri.parse('${BASE.URL_API}/api/v1/signin');
    var body = jsonEncode(user.toJson());
    var response = await http.put(url, body: body);
    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      if (success) {
        print(responseData['Data']['token_jwt']);
        //dataStatic.jwt = responseData['Data']['token_jwt'];
        //dataStatic.userName = user.userName;
      }

      return Future(() => success);
    }
    */
    return Future(() => false);
  }
}
