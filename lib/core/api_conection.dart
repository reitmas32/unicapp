import 'package:unicapp/core/uniaccounts/services/api_uniaccounts.dart';
import 'package:unicapp/service/apis/yonesto/api_yonesto.dart';
import 'package:unicapp/service/storages/product_storage.dart';
import 'package:unicapp/core/uniaccounts/models/user_storage.dart';

AccountAPI uniaccountsAPI = AccountAPI(storage: UserStorageSecurityStorage());
YonestoAPI yonestoAPI = YonestoAPI(storage: ProductStorageSecurityStorage());
