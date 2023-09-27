import 'package:unicapp/shared/config/envs.dart';

class UniaccountsBase {
  static const version = 'v1';
  String url = '${ENVS.uniaccounts.url}/api/${UniaccountsBase.version}';
  String apiKey = ENVS.uniaccounts.apiKey;
  String serviceName = ENVS.uniaccounts.serviceName;
}

var uniaccountsBase = UniaccountsBase();
