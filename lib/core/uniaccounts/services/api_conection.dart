import 'package:unicapp/core/uniaccounts/services/uniaccounts/api_uniaccounts.dart';
import 'package:unicapp/service/apis/yonesto/api_yonesto.dart';
import 'package:unicapp/service/storages/product_storage.dart';
import 'package:unicapp/service/storages/user_storage.dart';

AccountAPI uniaccountsAPI = AccountAPI(storage: UserStorageSecurityStorage());
YonestoAPI yonestoAPI = YonestoAPI(storage: ProductStorageSecurityStorage());
