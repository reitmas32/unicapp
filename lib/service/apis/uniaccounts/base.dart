import 'package:flutter_dotenv/flutter_dotenv.dart';

class UniaccountsBase {
  static const version = 'v1';
  String url =
      '${dotenv.env['UNIACCONTS_URL_API']}/api/${UniaccountsBase.version}';
}

var uniaccountsBase = UniaccountsBase();
