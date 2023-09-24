import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicapp/apps/yonesto/providers/providers.dart';

class SignInBody extends ConsumerWidget {
  const SignInBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
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
            fontWeight: isDarkMode ? FontWeight.w200 : FontWeight.w300,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
