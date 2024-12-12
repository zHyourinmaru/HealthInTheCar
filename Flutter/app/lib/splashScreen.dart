import 'package:app/VideoStream/VideoStreaming.dart';
import 'package:app/constants/theme.dart';
import 'package:app/navigationView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => Home(),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppTheme.mainBackground,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/images/teoresi_logo.svg',
                semanticsLabel: 'Svg Logo',
              ),
              iconSize: 100,
              onPressed: () {},
            ),
            SizedBox(height: 20),
            const Text(
              'Health In The Car',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: AppTheme.mainBlack,
                fontSize: 32,
              ),
            )
          ]),
    ));
  }
}
