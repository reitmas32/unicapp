import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonesto_ui/service/data_static.dart';
import 'package:yonesto_ui/ui/widgets/buttons/simple.dart';
import 'package:yonesto_ui/ui/widgets/buttons/theme_button.dart';

class YonestoDrawer extends StatelessWidget {
  const YonestoDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
            ),
            child: Text(
              'UNICapp',
              style: GoogleFonts.righteous(
                fontSize: 35,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SimpleButton(
              lable: 'Pay debts',
              onTap: () {},
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const ThemeButton(),
              SimpleButton(
                lable: 'Sign Out',
                onTap: () async {
                  if (await StorageConection.cleanJWT()) {
                    await StorageConection.cleanCode();
                    // ignore: use_build_context_synchronously
                    context.go('/');
                  }
                },
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
