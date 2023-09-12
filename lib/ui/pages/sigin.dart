import 'package:flutter/material.dart';
import 'package:yonesto_ui/ui/views/signin/body.dart';
import 'package:yonesto_ui/ui/views/signin/dont_account.dart';
import 'package:yonesto_ui/ui/views/signin/form.dart';
import 'package:yonesto_ui/ui/yonesto.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MinimalistAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SignInBody(),
            SignInForm(),
            SignInDontAccount(),
          ],
        ),
      ),
    );
  }
}
