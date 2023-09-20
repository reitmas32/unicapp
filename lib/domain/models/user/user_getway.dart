import 'package:yonesto_ui/domain/models/proccess_response/proccess_response.dart';
import 'package:yonesto_ui/domain/models/user/user.dart';
import 'package:yonesto_ui/domain/models/user/user_storage.dart';

abstract class AccontsUserAPI {
  final UserStorage storage;

  AccontsUserAPI({required this.storage});
  Future<ProccessResponce> singIn(User user);
}
