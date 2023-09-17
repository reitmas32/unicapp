import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yonesto_ui/models/product.dart';

class StorageConection {
  List<Product> products = [];
  //UserAdmin activeUserAdmin = UserAdmin(userName: '', password: '', id: '');
  //List<ComputerRoomUI> computerRooms = [];
  String jwt = '';
  String userName = '';

  static const storage = FlutterSecureStorage();
  static Future<bool> isSessionActive() async {
    String jwt = await StorageConection.storage.read(key: 'jwt') ?? '';

    bool response = jwt == '';
    return Future(() => response);
  }

  static Future<bool> writeJWT(String jwt) async {
    try {
      await StorageConection.storage.write(
        key: 'jwt',
        value: jwt,
      );
      return Future(() => true);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future(() => false);
    }
  }

  static Future<bool> cleanJWT() async {
    try {
      await StorageConection.storage.write(
        key: 'jwt',
        value: '',
      );
      return Future(() => true);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future(() => false);
    }
  }

  static Future<bool> writeCode(String code) async {
    try {
      await StorageConection.storage.write(
        key: 'code',
        value: code,
      );
      return Future(() => true);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future(() => false);
    }
  }

  static Future<String> readCode() async {
    String code = await StorageConection.storage.read(key: 'code') ?? '';

    return Future(() => code);
  }

  static Future<bool> cleanCode() async {
    try {
      await StorageConection.storage.write(
        key: 'code',
        value: '',
      );
      return Future(() => true);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future(() => false);
    }
  }

  static String decodeCode(String password) {
    /*
    String code_0 = StorageConection.hash[password[0]] ?? '';
    String code_1 = StorageConection.hash[password[2]] ?? '';
    String code_2 = StorageConection.hash[password[4]] ?? '';
    String code_3 = StorageConection.hash[password[6]] ?? '';
    String code_4 = StorageConection.hash[password[8]] ?? '';

    String code = code_0 + code_1 + code_2 + code_3 + code_4;
    */
    return '10064';
  }

  static const Map<String, String> hash = {
    '0': 'a',
    '1': 'b',
    '2': 'c',
    '3': 'd',
    '4': 'e',
    '5': 'f',
    '6': 'g',
    '7': 'h',
    '8': 'i',
    '9': 'j',
  };
}

StorageConection databaseStatic = StorageConection();
