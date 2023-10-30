import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:unicapp/ui/app.dart';
import 'package:unicapp/shared/config/envs.dart';

void main() async {
  setPathUrlStrategy();
  await ENVS.loadEnvs(fileName: '/etc/secrets/.env');
  runApp(const ProviderScope(child: YonestoApp()));
}
