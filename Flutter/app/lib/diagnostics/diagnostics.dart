import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app/constants/blueLine.dart';
import 'package:app/constants/textTheme.dart';
import 'package:app/VideoStream/VideoStreamHandler.dart';
import 'package:app/constants/theme.dart';
import 'package:app/diagnostics/diagnosticsCards.dart';
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

class Diagnostics extends StatelessWidget {
  const Diagnostics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppTheme.mainBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                Text('diagnostics'.tr,
                    style: Theme.of(context).textTheme.labelSmall),
                Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height / 1.19,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    DiagnosticBigCard(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DiagnosticCardNumber1(),
                        const SizedBox(width: 10),
                        DiagnosticCardNumber2(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DiagnosticCardSmile(),
                        const SizedBox(width: 10),
                        DiagnosticCardFrown(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DiagnosticCardHeart(),
                        const SizedBox(width: 10),
                        DiagnosticCardChart(),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
