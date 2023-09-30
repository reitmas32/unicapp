import 'package:flutter/material.dart';

import '../../yonesto/molecules/buttons/simple.dart';

class SignOptions extends StatelessWidget {
  const SignOptions({super.key, this.signIn});

  final VoidCallback? signIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: SimpleButton(
        lable: 'Sign In',
        onTap: signIn,
      ),
    );
  }
}
