import 'package:app/VideoStream/VideoStreaming.dart';
import 'package:app/constants/localization.dart';
import 'package:app/constants/theme.dart';
import 'package:app/navigationView.dart';
import 'package:app/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(const HealthInTheCar());
}

class HealthInTheCar extends StatelessWidget {
  const HealthInTheCar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocaleString(),
      locale: const Locale('it', 'IT'),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'Health In The Car',
      initialRoute: '/splashScreen',
      routes: {
        '/splashScreen': (context) => const SplashScreen(),
        '/home': (context) => Home(),
      },
    );
  }
}
