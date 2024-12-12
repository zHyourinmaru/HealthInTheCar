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

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool english = false;

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
                  Text('settings'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                  Expanded(child: SizedBox()),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                color: AppTheme.mainWhite,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(children: [
                      SizedBox(height: 10),
                      Text(
                        'changeLanguage'.tr,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: 10),
                      DecoratorHorizontal(),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("italian".tr,
                                style: Theme.of(context).textTheme.labelMedium),
                            SizedBox(width: 20),
                            Transform.scale(
                                scale: 2,
                                child: Switch(
                                  value: english,
                                  activeColor: AppTheme.mainBlue,
                                  onChanged: (bool value) {
                                    if (value == true) {
                                      var locale = Locale('en', 'UK');
                                      Get.updateLocale(locale);
                                    } else {
                                      var locale = Locale('it', 'IT');
                                      Get.updateLocale(locale);
                                    }
                                    setState(() {
                                      english = value;
                                    });
                                  },
                                )),
                            SizedBox(width: 20),
                            Text("english".tr,
                                style: Theme.of(context).textTheme.labelMedium),
                          ]),
                      SizedBox(height: 20),
                    ])),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/images/teoresi_logo.svg',
                  semanticsLabel: 'Svg Logo',
                ),
                iconSize: 100,
                onPressed: () {
                  // TODO: Rimanda alla pagina di TeoresiGroup
                },
              ),
              SizedBox(height: 20),
              Text('Copyright© 2023 Teoresi S.p.A.',
                  style: Theme.of(context).textTheme.labelSmall),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
            ]));
  }
}
