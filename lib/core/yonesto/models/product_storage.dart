import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unicapp/shared/models/proccess_response.dart';
import 'package:unicapp/core/yonesto/models/yonesto_storage.dart';

class ProductStorageSecurityStorage extends YonestoStorage {
  final storageConection = const FlutterSecureStorage();

  @override
  Future<ProccessResponce> cleanCode() {
    return save('code', '');
  }

  @override
  Future<ProccessResponce> loadCode() {
    return load('code');
  }

  @override
  Future<ProccessResponce> saveCode(String code) async {
    return save('code', code);
  }

  @override
  Future<ProccessResponce> save(String key, String value) async {
    try {
      await storageConection.write(
        key: key,
        value: value,
      );
      return Future(
        () => ProccessResponce(
          success: true,
          data: value,
          code: 200,
        ),
      );
    } on Exception catch (e) {
      return Future(
        () => ProccessResponce(
          success: false,
          data: e.toString(),
          code: 500,
        ),
      );
    }
  }

  @override
  Future<ProccessResponce> load(String key) async {
    try {
      var value = await storageConection.read(key: key) ?? '';
      return Future(
        () => ProccessResponce(
          success: true,
          data: value,
          code: 200,
        ),
      );
    } on Exception catch (e) {
      return Future(
        () => ProccessResponce(
          success: false,
          data: e.toString(),
          code: 500,
        ),
      );
    }
  }
}
