import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicapp/core/api_conection.dart';
import 'package:unicapp/service/data_static.dart';
import 'package:unicapp/ui/molecules/package.dart';
import 'package:unicapp/ui/widgets/info/request.dart';
import 'package:unicapp/ui/widgets/input/minimalist_text_filed.dart';

import 'dart:io' show Platform;

class YonestoDrawer extends StatelessWidget {
  const YonestoDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
            ),
            child: Text(
              'UNICapp',
              style: GoogleFonts.righteous(
                fontSize: 35,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SimpleButton(
              lable: 'Pay debts',
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const PayDebts();
                  },
                );
              },
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const ThemeButton(),
              SimpleButton(
                lable: 'Sign Out',
                onTap: () async {
                  if (await StorageConection.cleanJWT()) {
                    await StorageConection.cleanCode();
                    // ignore: use_build_context_synchronously
                    context.go('/');
                  }
                },
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class PayDebts extends StatefulWidget {
  const PayDebts({
    super.key,
  });

  @override
  State<PayDebts> createState() => _PayDebtsState();
}

class _PayDebtsState extends State<PayDebts> {
  TextEditingController paymentController = TextEditingController();
  String payment = '0.0';

  bool responseSuccessGetUnpaidsBuys = false;
  bool responseSuccessPayBuys = false;

  bool initProccessGetUnpaidsBuys = false;
  bool detachProccessGetUnpaidsBuys = false;
  bool initPay = false;
  bool initProcessPay = false;
  bool detachProcessPay = false;

  double totalRemainingAmount = 0;

  late int code;

  @override
  initState() {
    super.initState();
    loadUnpaidBuys();
  }

  loadUnpaidBuys() async {
    initProccessGetUnpaidsBuys = true;
    code = int.parse((await yonestoAPI.storage.loadCode()).data);

    var response = await yonestoAPI.getDebts(
      code,
    );

    responseSuccessGetUnpaidsBuys = response.success;

    totalRemainingAmount = response.data['totalRemainingAmount'];

    detachProccessGetUnpaidsBuys = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 1500), () {
      //Navigator.of(context).pop();
      setState(() {
        initPay = true;
      });
    });
  }

  createPay() async {
    initProcessPay = true;
    // ignore: use_build_context_synchronously
    setState(() {});

    code = int.parse((await yonestoAPI.storage.loadCode()).data);

    var responseSuccess =
        await yonestoAPI.payDebts(code, double.parse(payment));
    setState(() {
      responseSuccessPayBuys = responseSuccess.success;
    });

    detachProcessPay = true;
    // Cerrar el AlertDialog después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.of(context).pop();
      if (Platform.isWindows) {
        await StorageConection.cleanJWT();
        await StorageConection.cleanCode();
        // ignore: use_build_context_synchronously
        context.go('/');
      }
      //context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return initPay
        ? AlertDialogRequest(
            lable: 'Realizando Pago',
            successLable: 'Gracias por tu pago',
            errorLable: 'Error al realizar tu Pago',
            initProccess: initProcessPay,
            detachProccess: detachProcessPay,
            responseSuccess: responseSuccessPayBuys,
            actions: <Widget>[
              if (!initProcessPay)
                SimpleButton(
                    onTap: () async {
                      createPay();
                    },
                    lable: 'Pagar'),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MinimalistTextField(
                  lable: 'Cuanto Pagaras',
                  onlyNumbers: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  onChanged: (text) {
                    setState(() {
                      if (text == '') {
                        payment = '0.0';
                      } else {
                        payment = (text);
                      }
                    });
                  },
                  controller: paymentController,
                ),
                Text(
                  'Tu deuda es: ${totalRemainingAmount - double.parse(payment)}',
                ),
                Text(
                  'Tu Codigo es: $code',
                ),
              ],
            ),
          )
        : AlertDialogRequest(
            lable: 'Calculado Deuda',
            successLable: 'Tu deuda es de $totalRemainingAmount',
            errorLable: 'Error al calcular tu deuda',
            initProccess: initProccessGetUnpaidsBuys,
            detachProccess: detachProccessGetUnpaidsBuys,
            responseSuccess: responseSuccessGetUnpaidsBuys,
            child: const Text('Hola'),
          );
  }
}
