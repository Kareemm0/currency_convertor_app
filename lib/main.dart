import 'package:currency_convertor_app/app.dart';
import 'package:currency_convertor_app/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}
