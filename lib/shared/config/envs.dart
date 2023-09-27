import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore: unused_element
final class _ENVS {
  late UNIACCOUNTS uniaccounts;
  late YONESTO yonesto;
  String environment = 'development';

  _ENVS();

  loadEnvs({String fileName = '.env'}) async {
    await dotenv.load(fileName: fileName);
    if (dotenv.env['ENVIRONMENT'] != null) {
      environment = dotenv.env['ENVIRONMENT'] ?? '';
    }

    String pref = 'DEV';
    switch (environment) {
      case 'development':
        pref = 'DEV';
        break;
      case 'production':
        pref = 'PROD';

        break;
      case 'staging':
        pref = 'STG';

        break;
      default:
    }
    uniaccounts = UNIACCOUNTS(pref: pref);
    yonesto = YONESTO(pref: pref);
  }
}

final class UNIACCOUNTS {
  String apiKey = '';
  String serviceName = '';
  String url = '';
  final String pref;

  UNIACCOUNTS({this.pref = 'DEV'}) {
    apiKey = dotenv.env['${pref}_UNIACCONTS_API_KEY'] ?? '';
    serviceName = dotenv.env['${pref}_SERVICE_NAME'] ?? '';
    url = dotenv.env['${pref}_UNIACCONTS_URL_API'] ?? '';
  }
}

final class YONESTO {
  String apiKey = '';
  String url = '';
  final String pref;

  YONESTO({this.pref = 'DEV'}) {
    apiKey = dotenv.env['${pref}_YONESTO_API_KEY'] ?? '';
    url = dotenv.env['${pref}_YONESTO_URL_API'] ?? '';
  }
}

// ignore: library_private_types_in_public_api, non_constant_identifier_names
_ENVS ENVS = _ENVS();
