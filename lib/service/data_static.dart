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
}

StorageConection databaseStatic = StorageConection();
