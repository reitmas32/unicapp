import 'package:unicapp/shared/models/proccess_response.dart';
import 'package:unicapp/domain/models/product/product_storage.dart';
import 'package:unicapp/models/buy_request.dart';

abstract class YonestoAPIGetWay {
  final ProductStorage storage;

  YonestoAPIGetWay({required this.storage});
  Future<ProccessResponce> getProducts();
  Future<ProccessResponce> createBuy(BuyRequest buyRequest);
  Future<ProccessResponce> getDebts(int code);
  Future<ProccessResponce> payDebts(int code, double pay);
}
