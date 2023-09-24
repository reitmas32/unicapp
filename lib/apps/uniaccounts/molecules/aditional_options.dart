import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicapp/apps/uniaccounts/molecules/rememberme_chekbox.dart';
import 'package:unicapp/apps/yonesto/providers/providers.dart';

class AditionalOptions extends ConsumerWidget {
  const AditionalOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
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
                    fontWeight: isDarkMode ? FontWeight.w200 : FontWeight.w300,
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
                fontWeight: isDarkMode ? FontWeight.w200 : FontWeight.w300,
                fontSize: 15,
              ),
            ),
          ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
