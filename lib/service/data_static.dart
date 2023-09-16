import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yonesto_ui/models/product.dart';

class DataBaseStatic {
  List<Product> products = [];
  //UserAdmin activeUserAdmin = UserAdmin(userName: '', password: '', id: '');
  //List<ComputerRoomUI> computerRooms = [];
  String jwt = '';
  String userName = '';

  static final storage = FlutterSecureStorage();
}

DataBaseStatic databaseStatic = DataBaseStatic();
