import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/buttons/action_button.dart';
import 'package:unihacks_ui_kit/text_fields/multiple_textfields.dart';
import 'package:yonesto_ui/domain/models/product/product.dart';
import 'package:yonesto_ui/models/buy_request.dart';
import 'package:yonesto_ui/models/product_request.dart';
import 'package:yonesto_ui/providers/providers.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';
import 'package:yonesto_ui/service/data_static.dart';
import 'package:yonesto_ui/ui/widgets/info/request.dart';

class CompletePurchaseDialog extends ConsumerStatefulWidget {
  const CompletePurchaseDialog({super.key, required this.cart});

  final List<Product> cart;

  @override
  ConsumerState<CompletePurchaseDialog> createState() =>
      _CompletePurchaseDialogState();
}

class _CompletePurchaseDialogState
    extends ConsumerState<CompletePurchaseDialog> {
  TextEditingController idUserController = TextEditingController();

  TextEditingController paymentController = TextEditingController();
  String payment = '0.0';

  bool responseSuccess = false;
  bool initProccessBuy = false;
  bool detachProccessBuy = false;

  createBuy() async {
    initProccessBuy = true;
    // ignore: use_build_context_synchronously
    final code = (await yonestoAPI.storage.loadCode()).data;
    setState(() {});
    BuyRequest buyRequest = BuyRequest(
        clientCode: int.parse(code),
        payment: double.parse(payment),
        products: widget.cart
            .map((product) => ProductRequest(
                  product: product.id,
                  quantity: product.stock,
                ))
            .toList());

    var responseCreateBuy = await yonestoAPI.createBuy(buyRequest);

    responseSuccess = responseCreateBuy.success;

    if (responseSuccess) {
      ref.invalidate(shopProvider);
      ref.invalidate(cartProvider);
    }

    databaseStatic.products.clear();
    setState(() {});

    detachProccessBuy = true;
    // Cerrar el AlertDialog después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    return AlertDialogRequest(
      responseSuccess: responseSuccess,
      initProccess: initProccessBuy,
      detachProccess: detachProccessBuy,
      lable: 'Procesando Compra',
      successLable: 'Disfruta tu compra',
      errorLable: 'Error al generar tu Compra',
      actions: <Widget>[
        if (!initProccessBuy)
          ActionButton(
            onTap: () async {
              createBuy();
            },
            lable: 'Finalizar',
            color: Colors.purple,
          ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MultipleTextField(
            lable: 'Cuanto Pagaras',
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            onlyNumbers: true,
            onChanged: (text) {
              setState(() {
                if (text == '') {
                  payment = '0.0';
                } else {
                  payment = text;
                }
              });
            },
            textEditingController: paymentController,
          ),
          Text(
              'Tu deuda Aumentara en: ${calculateTotal(cart) - double.parse(payment)}'),
        ],
      ),
    );
  }

  double calculateTotal(List<Product> products) {
    double total = 0.0;
    for (var product in products) {
      total += product.stock * product.salePrice;
    }
    return total;
  }
}
