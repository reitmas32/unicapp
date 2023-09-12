import 'package:yonesto_ui/models/product.dart';

class DataBaseStatic {
  List<Product> products = [];
  //UserAdmin activeUserAdmin = UserAdmin(userName: '', password: '', id: '');
  //List<ComputerRoomUI> computerRooms = [];
  String jwt = '';
  String userName = '';
}

DataBaseStatic databaseStatic = DataBaseStatic();
