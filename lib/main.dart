import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:unicapp/ui/app.dart';

void main() async {
  setPathUrlStrategy();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: YonestoApp()));
}
