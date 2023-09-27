import 'package:unicapp/shared/config/envs.dart';

class YonestoBase {
  static const version = 'v1';
  String url = '${ENVS.yonesto.url}/api/${YonestoBase.version}/store';
  String apiKey = ENVS.yonesto.apiKey;
}

var yonestoBase = YonestoBase();
