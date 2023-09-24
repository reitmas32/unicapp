import 'package:unicapp/domain/models/proccess_response/proccess_response.dart';

abstract class UserStorage {
  Future<ProccessResponce> saveJWT(String jwt);
  Future<ProccessResponce> loadJWT();
  Future<ProccessResponce> cleanJWT();

  Future<ProccessResponce> saveUserName(String userName);
  Future<ProccessResponce> loadUserName();
  Future<ProccessResponce> cleanUserName();

  Future<ProccessResponce> save(String key, String value);
  Future<ProccessResponce> load(String key);
}
