import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app/constants/blueLine.dart';
import 'package:app/constants/textTheme.dart';
import 'package:app/VideoStream/VideoStreamHandler.dart';
import 'package:app/constants/theme.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:app/VideoStream/websocket.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:app/styles/styles.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DiagnosticBigCard extends StatefulWidget {
  const DiagnosticBigCard({super.key});

  @override
  State<DiagnosticBigCard> createState() => _DiagnosticBigCardState();
}

class _DiagnosticBigCardState extends State<DiagnosticBigCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: AppTheme.mainWhite,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4.5,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.lightGreen.withOpacity(0.4),
              ),
              child: Center(
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.mainWhite,
                  ),
                  child: Center(
                    child: Container(
                      width: 75.0,
                      height: 75.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.mainGreen,
                      ),
                      child: Center(
                        child: Text(
                          '84',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                width: 20), // Aggiunto uno spazio tra il cerchio e il testo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('data'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: 5),
                  Text('placeholder'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagnosticCardNumber1 extends StatefulWidget {
  const DiagnosticCardNumber1({super.key});

  @override
  State<DiagnosticCardNumber1> createState() => _DiagnosticCardNumber1State();
}

class _DiagnosticCardNumber1State extends State<DiagnosticCardNumber1> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: AppTheme.mainWhite,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4.5,
        width: MediaQuery.of(context).size.width / 2.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.lightGreen.withOpacity(0.4),
              ),
              child: Center(
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.mainWhite,
                  ),
                  child: Center(
                    child: Container(
                      width: 75.0,
                      height: 75.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.lightBlue,
                      ),
                      child: Center(
                        child: Text(
                          '84',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                width: 20), // Aggiunto uno spazio tra il cerchio e il testo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('data'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: 5),
                  Text('placeholderSmall'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagnosticCardNumber2 extends StatefulWidget {
  const DiagnosticCardNumber2({super.key});

  @override
  State<DiagnosticCardNumber2> createState() => _DiagnosticCardNumber2State();
}

class _DiagnosticCardNumber2State extends State<DiagnosticCardNumber2> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: AppTheme.mainWhite,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4.5,
        width: MediaQuery.of(context).size.width / 2.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.lightBlue.withOpacity(0.4),
              ),
              child: Center(
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.mainWhite,
                  ),
                  child: Center(
                    child: Container(
                      width: 75.0,
                      height: 75.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.mainBlue,
                      ),
                      child: Center(
                        child: Text(
                          '84',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                width: 20), // Aggiunto uno spazio tra il cerchio e il testo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('data'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: 5),
                  Text('placeholderSmall'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagnosticCardSmile extends StatefulWidget {
  const DiagnosticCardSmile({super.key});

  @override
  State<DiagnosticCardSmile> createState() => _DiagnosticCardSmileState();
}

class _DiagnosticCardSmileState extends State<DiagnosticCardSmile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: AppTheme.mainWhite,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4.5,
        width: MediaQuery.of(context).size.width / 2.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.smile,
              size: 100,
              color: AppTheme.lightGreen,
            ),
            SizedBox(
                width: 20), // Aggiunto uno spazio tra il cerchio e il testo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('data'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: 5),
                  Text('placeholderSmall'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagnosticCardFrown extends StatefulWidget {
  const DiagnosticCardFrown({super.key});

  @override
  State<DiagnosticCardFrown> createState() => _DiagnosticCardFrownState();
}

class _DiagnosticCardFrownState extends State<DiagnosticCardFrown> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: AppTheme.mainWhite,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4.5,
        width: MediaQuery.of(context).size.width / 2.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.frown,
              size: 100,
              color: AppTheme.lightBlue,
            ),
            SizedBox(
                width: 20), // Aggiunto uno spazio tra il cerchio e il testo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('data'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: 5),
                  Text('placeholderSmall'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagnosticCardHeart extends StatefulWidget {
  const DiagnosticCardHeart({super.key});

  @override
  State<DiagnosticCardHeart> createState() => _DiagnosticCardHeartState();
}

class _DiagnosticCardHeartState extends State<DiagnosticCardHeart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: AppTheme.mainWhite,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4.5,
        width: MediaQuery.of(context).size.width / 2.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.heart,
              size: 100,
              color: AppTheme.mainGreen,
            ),
            SizedBox(
                width: 20), // Aggiunto uno spazio tra il cerchio e il testo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('data'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: 5),
                  Text('placeholderSmall'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagnosticCardChart extends StatefulWidget {
  const DiagnosticCardChart({super.key});

  @override
  State<DiagnosticCardChart> createState() => _DiagnosticCardChartState();
}

class _DiagnosticCardChartState extends State<DiagnosticCardChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: AppTheme.mainWhite,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4.5,
        width: MediaQuery.of(context).size.width / 2.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.barChart2,
              size: 100,
              color: AppTheme.mainBlue,
            ),
            SizedBox(
                width: 20), // Aggiunto uno spazio tra il cerchio e il testo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('data'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: 5),
                  Text('placeholderSmall'.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
