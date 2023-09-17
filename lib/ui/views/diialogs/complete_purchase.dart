import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/buttons/action_button.dart';
import 'package:unihacks_ui_kit/text_fields/multiple_textfields.dart';
import 'package:yonesto_ui/models/buy_request.dart';
import 'package:yonesto_ui/models/product_request.dart';
import 'package:yonesto_ui/providers/cart.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';
import 'package:yonesto_ui/service/data_static.dart';
import 'package:yonesto_ui/ui/widgets/info/request.dart';

class CompletePurchaseDialog extends StatefulWidget {
  const CompletePurchaseDialog({super.key});

  @override
  State<CompletePurchaseDialog> createState() => _CompletePurchaseDialogState();
}

class _CompletePurchaseDialogState extends State<CompletePurchaseDialog> {
  TextEditingController idUserController = TextEditingController();

  TextEditingController paymentController = TextEditingController();
  String payment = '0.0';

  bool responseSuccess = false;
  bool initProccessBuy = false;
  bool detachProccessBuy = false;

  createBuy(CartProvider cart) async {
    initProccessBuy = true;
    // ignore: use_build_context_synchronously
    setState(() {});
    BuyRequest buyRequest = BuyRequest(
        clientCode: int.parse(await StorageConection.readCode()),
        payment: double.parse(payment),
        products: cart.cart
            .map((product) => ProductRequest(
                  product: product.id,
                  quantity: product.stock,
                ))
            .toList());
    responseSuccess = await yonestoAPI.createBuy(buyRequest);

    if (responseSuccess) {
      databaseStatic.products.clear();
      cart.quanty = 0;
      //cart.cleanCart();
      //context.go('/home');
    }
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
    final cart = Provider.of<CartProvider>(context);
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
              createBuy(cart);
              //context.go('/home');
            },
            lable: 'Finalizar',
            color: Colors.purple,
          ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MultipleTextField(
            lable: 'Cunato Pagaras',
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
              'Tu deuda Aumentara en: ${cart.calculateTotal() - double.parse(payment)}'),
        ],
      ),
    );
  }
}
