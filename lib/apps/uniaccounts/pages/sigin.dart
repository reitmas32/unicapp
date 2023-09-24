import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicapp/core/api_conection.dart';
import 'package:unicapp/ui/views/signin/body.dart';
import 'package:unicapp/ui/views/signin/dont_account.dart';
import 'package:unicapp/ui/views/signin/form.dart';
import 'package:unicapp/ui/views/common/app_bar.dart';

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
      appBar: MinimalistAppBar(),
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
