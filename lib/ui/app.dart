import 'package:flutter/material.dart';
import 'package:yonesto_ui/ui/yonesto.dart';

class YonestoApp extends StatefulWidget {
  const YonestoApp({super.key});

  @override
  State<YonestoApp> createState() => _YonestoAppState();
}

class _YonestoAppState extends State<YonestoApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Yonesto();
  }
}
