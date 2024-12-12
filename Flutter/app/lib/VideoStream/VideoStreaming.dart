import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
import 'package:get/get.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({Key? key}) : super(key: key);

  static ValueNotifier<String> imageToVisualize = ValueNotifier("1");
  static ValueNotifier<String> heartBeatToVisualize = ValueNotifier("0");
  static ValueNotifier<bool> error01 = ValueNotifier(false);

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  //final WebSocket _socket = WebSocket(Constants.videoWebsocketURL);
  //final WebSocket _socket = WebSocket();

  late VideoStreamHandler videoStreamHandler;
  late CameraController cameraController;
  static final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  final String _errorAudioPath = 'assets/sounds/error.mp3';
  final String _correctAudioPath = 'assets/sounds/correct.mp3';

  String _state = "menu";
  bool _errorVisible = false;

  @override
  void initState() {
    super.initState();
    videoStreamHandler = VideoStreamHandler();
    initializeCamera();
  }

  @override
  void dispose() {
    videoStreamHandler.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void initializeCamera() async {
    await videoStreamHandler.initializeCamera();

    cameraController = videoStreamHandler.cameraController;
  }

  void calibration(BuildContext context) async {
    //_socket.connect();

    VideoStream.imageToVisualize = ValueNotifier("1");

    setState(() {
      _state = "calibration";
      showCorrect();
    });

    videoStreamHandler.startCalibration();
    Future.delayed(Duration(seconds: 3));
    videoStreamHandler.startStreaming();

    VideoStream.imageToVisualize.addListener(() {
      if (VideoStream.imageToVisualize.value == "6") {
        disconnect();
        showCompletedDialog(context);
      } else {
        showCorrect();
      }
    });

    VideoStream.error01.addListener(() {
      if (VideoStream.error01.value) {
        showError();
      }
    });
  }

  void detect(BuildContext context) async {
    VideoStream.imageToVisualize = ValueNotifier("ZORIGINAL");

    setState(() {
      _state = "detect";
    });

    videoStreamHandler.startDetect();
    Future.delayed(Duration(seconds: 5));
    videoStreamHandler.startStreaming();
  }

  void disconnect() {
    setState(() {
      _state = "menu";
      videoStreamHandler.stopStreaming();
    });
    //_socket.disconnect();
  }

  void showCompletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('calibrationCompleted'.tr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il dialog
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showCorrect() async {
    _audioPlayer.open(Audio(_correctAudioPath));
    _audioPlayer.play();
  }

  void showError() {
    setState(() {
      _errorVisible = true;
    });

    _audioPlayer.open(Audio(_errorAudioPath));
    _audioPlayer.play();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        VideoStream.error01.value = false;
        _errorVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Esegui l'azione desiderata quando l'utente preme "indietro"
          if (_state != "menu") {
            setState(() {
              _state = "menu";
            });
            videoStreamHandler.stopStreaming();
            return false; // Impedisci il ritorno alla schermata precedente
          }
          return true; // Consenti il ritorno alla schermata precedente
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppTheme.mainBackground,
            child: _state == "menu"
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width / 1.2,
                                  MediaQuery.of(context).size.height / 8),
                              backgroundColor: AppTheme.mainWhite,
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                            ),
                            onPressed: () => calibration(context),
                            child: Text(
                              'calibration'.tr,
                              style: Theme.of(context).textTheme.labelLarge,
                            )),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width / 1.2,
                                MediaQuery.of(context).size.height / 8),
                            backgroundColor: AppTheme.mainWhite,
                            textStyle: Theme.of(context).textTheme.labelLarge,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                          onPressed: () => detect(context),
                          child: Text(
                            'detect'.tr,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Tooltip(
                            message: "tutorial".tr,
                            child: IconButton(
                                color: AppTheme.lightBlue,
                                onPressed: () {},
                                iconSize: 100,
                                icon: const Icon(FeatherIcons.helpCircle)))
                      ])
                : _state == "calibration"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 5),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  color: AppTheme.mainWhite,
                                  child: Text('calibration'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall),
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                            ValueListenableBuilder(
                              valueListenable: VideoStream.imageToVisualize,
                              builder: (BuildContext context,
                                  String imageToVisualize, Widget? child) {
                                return Image(
                                    image: AssetImage(
                                        "assets/images/Z$imageToVisualize.png"));
                              },
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CameraPreview(cameraController),
                                const CameraDecoration(),
                                AnimatedOpacity(
                                  opacity: _errorVisible ? 1.0 : 0.0,
                                  duration: const Duration(seconds: 3),
                                  child: Text('error01'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ],
                            )
                          ])
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 5),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  color: AppTheme.mainWhite,
                                  child: Text('detect'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall),
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                            ValueListenableBuilder(
                              valueListenable: VideoStream.imageToVisualize,
                              builder: (BuildContext context,
                                  String imageToVisualize, Widget? child) {
                                return Image(
                                    image: AssetImage(
                                        "assets/images/$imageToVisualize.png"));
                              },
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CameraPreview(cameraController),
                                const CameraDecoration(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Spacer(),
                                            Card(
                                                margin: EdgeInsets.all(10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                color: AppTheme.mainWhite,
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(width: 10),
                                                      ValueListenableBuilder(
                                                        valueListenable: VideoStream
                                                            .heartBeatToVisualize,
                                                        builder: (BuildContext
                                                                context,
                                                            String
                                                                heartBeatToVisualize,
                                                            Widget? child) {
                                                          return Text(
                                                              heartBeatToVisualize,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelMedium);
                                                        },
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Icon(
                                                          FeatherIcons.heart,
                                                          color:
                                                              AppTheme.mainRed,
                                                          size: 40),
                                                      const SizedBox(width: 10),
                                                    ])),
                                          ]),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2),
                                    ])
                              ],
                            )
                          ])));
  }
}

class CameraDecoration extends StatelessWidget {
  const CameraDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5 * 1.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
        ),
      ),
    );
  }
}
