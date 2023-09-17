import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihacks_ui_kit/themes/theme_preference.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return IconButton(
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
    );
  }
}
