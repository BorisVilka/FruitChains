import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitchains/company.dart';
import 'package:fruitchains/game.dart';
import 'package:fruitchains/loader.dart';
import 'package:fruitchains/menu.dart';
import 'package:fruitchains/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const CompanyScreen(),
      '/loader': (context) => LoaderScreen(),
      '/menu': (context) => MenuScreen(),
      '/settings': (context) => const SettingsScreen(),
      '/game': (context) => GameScreen()
    },
  ));
}

