import 'package:yonesto_ui/domain/models/proccess_response/proccess_response.dart';
import 'package:yonesto_ui/domain/models/product/product_storage.dart';
import 'package:yonesto_ui/models/buy_request.dart';

abstract class ProductsAPI {
  final ProductStorage storage;

  ProductsAPI({required this.storage});
  Future<ProccessResponce> getProducts();
  Future<ProccessResponce> createBuy(BuyRequest buyRequest);
  Future<ProccessResponce> getDebts(int code);
  Future<ProccessResponce> payDebts(int code, double pay);
}
