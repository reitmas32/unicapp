import 'package:yonesto_ui/service/apis/uniaccounts/api_uniaccounts.dart';
import 'package:yonesto_ui/service/apis/yonesto/api_connection.dart';
import 'package:http/http.dart' as http;

final http.Client httpClient = http.Client();
AccountAPI uniaccountsAPI = AccountAPI();
YonestoAPI yonestoAPI = YonestoAPI(httpClient);
