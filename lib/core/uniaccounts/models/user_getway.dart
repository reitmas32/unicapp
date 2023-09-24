import 'package:unicapp/domain/models/proccess_response/proccess_response.dart';
import 'package:unicapp/core/uniaccounts/models/user.dart';
import 'package:unicapp/core/uniaccounts/models/user_storage.dart';

abstract class AccontsUserAPI {
  final UserStorage storage;

  AccontsUserAPI({required this.storage});
  Future<ProccessResponce> singIn(User user);
}
