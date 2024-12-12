import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';

import 'package:app/VideoStream/websocket.dart';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as imglib;
import 'package:provider/provider.dart';

//int count = 0;

class VideoStreamHandler {
  final WebSocket _webSocket;
  late CameraController _cameraController;
  late StreamController<List<int>> _videoStreamController;
  late StreamSubscription<void> _subscription;

  VideoStreamHandler() : _webSocket = WebSocket() {
    _videoStreamController = StreamController<List<int>>();
    _subscription = _videoStreamController.stream.listen(_sendFrame);
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    // Usa la fotocamera frontale
    _cameraController = CameraController(frontCamera, ResolutionPreset.low,
        imageFormatGroup: ImageFormatGroup.nv21, enableAudio: false);

    await _cameraController.initialize();

    // Ottieni le informazioni sulla risoluzione
    //int cameraWidth = _cameraController.value.previewSize!.width.toInt();
    //int cameraHeight = _cameraController.value.previewSize!.height.toInt();

    //print("---------------------------------------------------");
    //print(cameraHeight);
    //print(cameraWidth);
    //print("---------------------------------------------------");

    // Invia le informazioni sulla risoluzione al server
    //_webSocket.sendResolutionInfo(cameraWidth, cameraHeight);
  }

  CameraController get cameraController => _cameraController;

  void startCalibration() {
    _webSocket.sendCalibrationSignal();
  }

  void startDetect() {
    _webSocket.sendDetectSignal();
  }

  void _stopFunction() {
    _webSocket.sendStopSignal();
  }

  void startStreaming() {
    _cameraController.startImageStream((CameraImage image) {
      _videoStreamController
          .add(image.planes.expand((plane) => plane.bytes).toList());
      // Applica la logica di conversione per ottenere i dati YUV
      //List<int> frame = conversionLogic(image);
      //_videoStreamController.add(frame);
    });
  }

  void stopStreaming() {
    _stopFunction();
    _cameraController.stopImageStream();
  }

  void dispose() {
    _subscription.cancel();
    _videoStreamController.close();
  }

  void _sendFrame(List<int> frame) {
    // Invia i dati video direttamente come dati binari
    //count++;
    _webSocket.sendVideo(frame);
  }

  List<int> conversionLogic(CameraImage image) {
    // Ottieni i dati YUV direttamente dall'oggetto CameraImage
    List<int> byteList = [];

    String format = image.format.group.toString();
    //print("Format: $format");

    // Logica necessaria per ottenere i dati YUV dal CameraImage
    for (var plane in image.planes) {
      //print("Dimensione piano: ${plane.bytes.length}");
      byteList.addAll(plane.bytes);
    }

    // Stampe di debug
    //print("Dimensione dei dati YUV: ${byteList.length}");
    //print("Primi 10 elementi dei dati YUV: ${byteList.sublist(0, 10)}");

    return byteList;
  }
}
