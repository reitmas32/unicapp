import 'package:flutter/material.dart';
import 'package:unicapp/ui/widgets/input/minimalist_text_filed.dart';

class AccountsTextFieds extends StatelessWidget {
  const AccountsTextFieds({
    super.key,
    required this.userNameController,
    required this.passwordController,
  });

  final TextEditingController userNameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MinimalistTextField(
          lable: 'User Name',
          controller: userNameController,
        ),
        MinimalistTextField(
          lable: 'Password',
          isPassword: true,
          controller: passwordController,
        ),
      ],
    );
  }
}
