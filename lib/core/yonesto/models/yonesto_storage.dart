import 'package:unicapp/shared/models/proccess_response.dart';

abstract class YonestoStorage {
  Future<ProccessResponce> saveCode(String code);
  Future<ProccessResponce> loadCode();
  Future<ProccessResponce> cleanCode();

  Future<ProccessResponce> save(String key, String value);
  Future<ProccessResponce> load(String key);
}
