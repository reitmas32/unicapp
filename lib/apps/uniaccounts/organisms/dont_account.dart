import 'package:flutter/material.dart';

class SignInDontAccount extends StatelessWidget {
  const SignInDontAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?'),
        SizedBox(
          width: 10,
        ),
        Text('SignUp'),
      ],
    );
  }
}
