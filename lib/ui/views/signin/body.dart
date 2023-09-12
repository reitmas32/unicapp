import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Welcom Back',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 40,
            ),
          ),
        ),
        Text(
          'Sign in with you username and password',
          style: GoogleFonts.roboto(
            fontWeight:
                currentTheme.isDarkTheme() ? FontWeight.w200 : FontWeight.w300,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
