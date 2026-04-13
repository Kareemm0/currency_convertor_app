import 'package:currency_convertor_app/app.dart';
import 'package:currency_convertor_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initDependencies();
  runApp(const MyApp());
}
