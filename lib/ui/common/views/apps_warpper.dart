import 'package:flutter/material.dart';
import 'package:unicapp/ui/common/molecules/app_button.dart';

class AppsWrapper extends StatelessWidget {
  const AppsWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 0, // Espacio horizontal entre contenedores
      runSpacing: 50,
      alignment: WrapAlignment.center,
      children: [
        AppButton(
          iconData: Icons.shopping_bag,
          backgroundColor: Colors.green,
          route: '/yonesto/shop',
          lable: 'Yonesto',
        ),
        AppButton(
          iconData: Icons.monetization_on,
          backgroundColor: Colors.orange,
          lable: 'Depositar',
          route: '',
        ),
        AppButton(
          iconData: Icons.money_rounded,
          backgroundColor: Colors.pink,
          lable: 'Retirar',
          route: '',
        ),
        AppButton(
          iconData: Icons.compare_arrows_rounded,
          backgroundColor: Colors.purple,
          lable: 'Transferir',
          route: '',
        ),
        AppButton(
          iconData: Icons.payment,
          backgroundColor: Colors.blue,
          lable: 'Pagar',
          route: '',
        ),
      ],
    );
  }
}
