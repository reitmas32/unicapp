import 'package:yonesto_ui/service/apis/uniaccounts/api_uniaccounts.dart';
import 'package:yonesto_ui/service/apis/yonesto/api_yonesto.dart';
import 'package:yonesto_ui/service/storages/product_storage.dart';
import 'package:yonesto_ui/service/storages/user_storage.dart';

AccountAPI uniaccountsAPI = AccountAPI(storage: UserStorageSecurityStorage());
YonestoAPI yonestoAPI = YonestoAPI(storage: ProductStorageSecurityStorage());
