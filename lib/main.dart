import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:yonesto_ui/service/apis/api_conection.dart';
import 'package:yonesto_ui/ui/app.dart';

void main() async {
  setPathUrlStrategy();
  await dotenv.load(fileName: ".env");
  await yonestoAPI.getProducts();
  runApp(const YonestoApp());
}
