import 'package:yonesto_ui/domain/models/proccess_response/proccess_response.dart';

abstract class ProductStorage {
  Future<ProccessResponce> saveCode(String code);
  Future<ProccessResponce> loadCode();
  Future<ProccessResponce> cleanCode();

  Future<ProccessResponce> save(String key, String value);
  Future<ProccessResponce> load(String key);
}
