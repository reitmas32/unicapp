import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/domain/models/proccess_response/proccess_response.dart';
import 'package:yonesto_ui/domain/models/user/user.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';
import 'package:yonesto_ui/ui/widgets/buttons/simple.dart';
import 'package:yonesto_ui/ui/widgets/input/minimalist_text_filed.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
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
          MinimalistTextField(
            lable: 'User Name',
            controller: userNameController,
          ),
          MinimalistTextField(
            lable: 'Password',
            isPassword: true,
            controller: passwordController,
          ),
          if (size.width > 700)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RememberMe(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: Text(
                    'Forgot Password',
                    style: GoogleFonts.roboto(
                      fontWeight: currentTheme.isDarkTheme()
                          ? FontWeight.w200
                          : FontWeight.w300,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          if (size.width < 700) const RememberMe(),
          if (size.width < 700)
            const SizedBox(
              height: 20,
            ),
          if (size.width < 700)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Text(
                'Forgot Password',
                style: GoogleFonts.roboto(
                  fontWeight: currentTheme.isDarkTheme()
                      ? FontWeight.w200
                      : FontWeight.w300,
                  fontSize: 15,
                ),
              ),
            ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 100,
            ),
            child: SimpleButton(
              lable: 'Sign Out',
              onTap: singIn,
            ),
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

class RememberMe extends StatefulWidget {
  const RememberMe({
    super.key,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool remember = false;
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: remember,
            activeColor: Colors.purple,
            onChanged: (value) {
              setState(() {
                remember = value ?? false;
              });
            },
          ),
          Text(
            'Remember me',
            style: GoogleFonts.roboto(
              fontWeight: currentTheme.isDarkTheme()
                  ? FontWeight.w200
                  : FontWeight.w300,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
