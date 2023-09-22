import 'package:flutter/material.dart';
import 'package:unihacks_ui_kit/themes/theme_provider.dart';
import 'package:yonesto_ui/ui/yonesto.dart';

class YonestoApp extends StatefulWidget {
  const YonestoApp({super.key});

  @override
  State<YonestoApp> createState() => _YonestoAppState();
}

class _YonestoAppState extends State<YonestoApp> {
  ThemeProvider themeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme(themeProvider);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Yonesto();
  }
}
