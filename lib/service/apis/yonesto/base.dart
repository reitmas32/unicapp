import 'package:flutter_dotenv/flutter_dotenv.dart';

class YonestoBase {
  static const version = 'v1';
  String url =
      '${dotenv.env['YONESTO_URL_API']}/api/${YonestoBase.version}/store';
}

var yonestoBase = YonestoBase();
