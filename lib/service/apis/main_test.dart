import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yonesto_ui/models/user.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: ".env");
  print(
    await uniaccountsAPI.signIn(
      User(
        userName: 'rafael78',
        password: 'rafa123',
      ),
    ),
  );
}
