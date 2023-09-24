import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unicapp/apps/uniaccounts/molecules/accounts_textfields.dart';
import 'package:unicapp/apps/uniaccounts/molecules/aditional_options.dart';
import 'package:unicapp/apps/uniaccounts/molecules/sign_options.dart';
import 'package:unicapp/shared/models/proccess_response.dart';
import 'package:unicapp/core/uniaccounts/models/user.dart';
import 'package:unicapp/core/api_conection.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 1200
            ? size.width / 3
            : size.width > 1000
                ? size.width / 5
                : 0,
      ),
      child: Column(
        children: [
          AccountsTextFieds(
            userNameController: userNameController,
            passwordController: passwordController,
          ),
          const AditionalOptions(),
          SignOptions(
            signIn: singIn,
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  singIn() async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Evita que el usuario cierre el diálogo tocando fuera de él
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Espera'),
          content: Text('Iniciando sesión...'),
          // Puedes personalizar el contenido y el estilo de tu AlertDialog aquí
        );
      },
    );

    ProccessResponce response = await uniaccountsAPI.singIn(User(
      userName: userNameController.text,
      password: passwordController.text,
    ));

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    String message = '';

    if (response.code == 200) {
      message = 'Todo BIen';
    }
    if (response.code == 500) {
      message = 'No existe el usuario';
    }
    if (response.code == 401) {
      message = 'NO apy Key valid';
    }
    if (response.code == 400) {
      message = 'Faltan parametros';
    }

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    if (response.code == 200) {
      // ignore: use_build_context_synchronously
      context.go('/home');
    }
  }
}
