import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/buttons/theme_swtcher.dart';
import 'package:unihacks_ui_kit/themes/theme_preference.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';

class YonestoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const YonestoAppBar({
    super.key,
    required this.title,
  });

  final Widget title;

  @override
  State<YonestoAppBar> createState() => _YonestoAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _YonestoAppBarState extends State<YonestoAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: widget.title,
      titleSpacing: size.width > 750 ? 200 : 0,
      actions: const [
        ThemeSwitcher(),
      ],
      leading: IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {
          context.go('/home');
        },
      ),
    );
  }
}

class MinimalistAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MinimalistAppBar({
    super.key,
  });

  @override
  State<MinimalistAppBar> createState() => _MinimalistAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MinimalistAppBarState extends State<MinimalistAppBar> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.5,
      actions: [
        IconButton(
          onPressed: () {
            if (currentTheme.isDarkTheme()) {
              setState(() {
                currentTheme.setTheme = ThemePreference.LIGHT;
              });
            } else {
              setState(() {
                currentTheme.setTheme = ThemePreference.DARK;
              });
            }
          },
          icon: Icon(
            currentTheme.isDarkTheme() ? Icons.wb_sunny : EvaIcons.moon,
          ),
        ),
      ],
      title: Center(
        child: Text(
          'Sign In',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w200,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
