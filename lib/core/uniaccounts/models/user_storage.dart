import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unicapp/shared/models/proccess_response.dart';
import 'package:unicapp/core/uniaccounts/models/user_storage_interface.dart';

class UserStorageSecurityStorage extends UserStorage {
  final storageConection = const FlutterSecureStorage();

  @override
  Future<ProccessResponce> cleanJWT() {
    return save('jwt', '');
  }

  @override
  Future<ProccessResponce> cleanUserName() {
    return save('user_name', '');
  }

  @override
  Future<ProccessResponce> loadJWT() {
    return load('jwt');
  }

  @override
  Future<ProccessResponce> loadUserName() {
    return load('user_name');
  }

  @override
  Future<ProccessResponce> saveJWT(String jwt) async {
    return save('jwt', jwt);
  }

  @override
  Future<ProccessResponce> saveUserName(String userName) {
    return save('user_name', userName);
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
