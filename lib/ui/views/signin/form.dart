import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/models/user.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';
import 'package:yonesto_ui/ui/widgets/minimalist_text_field.dart';

class SignInForm extends StatelessWidget {
  SignInForm({super.key});
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
                : size.width / 8,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: SizedBox(
              width: 300,
              height: 45,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        var response = await uniaccountsAPI.signIn(User(
                          userName: userNameController.text,
                          password: passwordController.text,
                        ));
                        String message = '';
                        if (response == 200) {
                          message = 'Todo BIen';
                        }
                        if (response == 500) {
                          message = 'No existe el usuario';
                        }
                        if (response == 401) {
                          message = 'NO apy Key valid';
                        }
                        if (response == 400) {
                          message = 'Faltan parametros';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text(
                              message,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            duration: const Duration(
                                seconds: 2), // Duración del SnackBar
                          ),
                        );
                        if (response != -1) {
                          await yonestoAPI.getProducts();
                          print('la respuesta es $response');
                          context.go('/home');
                        }
                        // Navega a la pantalla de inicio solo si la llamada fue exitosa
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
