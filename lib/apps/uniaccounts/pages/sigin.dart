import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicapp/core/api_conection.dart';
import 'package:unicapp/apps/uniaccounts/organisms/body.dart';
import 'package:unicapp/apps/uniaccounts/organisms/dont_account.dart';
import 'package:unicapp/apps/uniaccounts/organisms/form.dart';
import 'package:unicapp/ui/views/common/app_bar.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  @override
  initState() {
    super.initState();
    loadJWT();
  }

  Future<void> loadJWT() async {
    var responseJWT = await uniaccountsAPI.storage.loadJWT();
    if (responseJWT.data != '') {
      // ignore: use_build_context_synchronously
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MinimalistAppBar(title: 'SignIn'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SignInBody(),
              SignInForm(),
              SignInDontAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
