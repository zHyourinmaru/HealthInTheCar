import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:app/VideoStream/VideoStreaming.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

//int count = 0;

class WebSocket {
  // ------------------------- Members ------------------------- //
  static final WebSocket _singleton = WebSocket._internal();
  final String _url = "ws://192.168.1.32:8787";
  late Timer _pingTimer;
  WebSocketChannel? _channel;
  StreamController<bool> streamController = StreamController<bool>.broadcast();
  String oldImg = "1";
  bool detect = false;
  bool calibration = false;

  // ---------------------- Getter Setters --------------------- //
  factory WebSocket() {
    return _singleton;
  }

  WebSocket._internal();

  Stream<dynamic> get stream {
    if (_channel != null) {
      return _channel!.stream;
    } else {
      throw WebSocketChannelException("The connection was not established !");
    }
  }

  // ---------------------- Functions ----------------------- //

  // Connects the current application to a websocket
  void connect() async {
    _channel = WebSocketChannel.connect(Uri.parse(_url));

    startPing();

    // Gestisci i messaggi dal server
    _channel!.stream.listen((message) {
      if (message == "pong") {
        _handlePong(message);
      } else if (calibration == true) {
        _handleCalibrationImageData(message);
      } else if (detect == true) {
        _handleDetectData(message);
      }
    }, onDone: () {
      print("Disconnected from the server");
      _channel = null;
      stopPing();

      // Attempt to reconnect after a delay
      Timer(Duration(seconds: 5), () {
        print("Attempting to reconnect...");
        connect();
      });
    }, onError: (error) {
      print("Connection error: $error");
    });
  }

  // Disconnects the current application from a websocket
  void disconnect() {
    if (_channel != null) {
      _channel!.sink.close(status.goingAway);
      _channel = null;
      stopPing();
    }
  }

  void _resetOldImg() {
    oldImg = "1";
  }

  void startPing() {
    if (_channel != null) {
      _pingTimer = Timer.periodic(Duration(seconds: 10), (timer) {
        _sendPing();
      });
    }
  }

  void _sendPing() {
    if (_channel != null && _channel!.sink != null) {
      try {
        _channel!.sink.add("ping");
        print("ping inviato con successo");
      } catch (e) {
        print("Errore nell'invio del ping: $e");
      }
    }
  }

  void stopPing() {
    _pingTimer.cancel();
  }

  void _handlePong(dynamic data) {
    if (data == "pong") {
      print("Ricevuto Pong dal server");
    }
  }

  void _handleCalibrationImageData(dynamic data) {
    if (data == "Error 01") {
      print("Error 01");
      VideoStream.error01.value = true;
    } else {
      oldImg = data;
      print("Ricevuto cambio img");
      VideoStream.imageToVisualize.value = data;
    }
  }

  void _handleDetectData(dynamic data) {
    if (data == "Error 02") {
      print("Error 02");
    } else if (data == "Error 03") {
      print("Error 03");
    } else if (data.toString().startsWith('Z')) {
      print("Ricevuto predizione zona");
      if (data == "Z10") {
        VideoStream.imageToVisualize.value = "ZORIGINAL";
      } else {
        VideoStream.imageToVisualize.value = data;
      }
    } else {
      print("Ricevuta Frequenza Cardiaca");
      VideoStream.heartBeatToVisualize.value = data;
    }
  }

  Future<void> sendResolutionInfo(int width, int height) async {
    if (_channel != null && _channel!.sink != null) {
      try {
        // Crea un messaggio JSON con le informazioni sulla risoluzione
        Map<String, dynamic> resolutionInfo = {
          'type': 'resolution',
          'width': width,
          'height': height,
        };

        String jsonMessage = jsonEncode(resolutionInfo);
        int expectedSize =
            width * height * 3; // Considerando 3 componenti (Y, U, V) per pixel
        //print("Dimensione prevista dei dati YUV: $expectedSize");

        // Invia il messaggio JSON al server
        _channel!.sink.add(jsonMessage);
      } catch (e) {
        print("Errore nell'invio delle informazioni sulla risoluzione: $e");
      }
    } else {
      throw WebSocketChannelException("La connessione non è stata stabilita!");
    }
  }

  void sendCalibrationSignal() {
    if (_channel != null && _channel!.sink != null) {
      try {
        _channel!.sink.add("calibration");
        print("Calibrazione iniziato con successo.");
        calibration = true;
        _resetOldImg();
      } catch (e) {
        print("Errore nell'invio del messaggio di Calibrazione: $e");
      }
    }
  }

  void sendDetectSignal() {
    if (_channel != null && _channel!.sink != null) {
      try {
        _channel!.sink.add("detect");
        print("Rileva Viso iniziato con successo.");
        detect = true;
      } catch (e) {
        print("Errore nell'invio del messaggio di Detect: $e");
      }
    }
  }

  void sendStopSignal() {
    if (_channel != null && _channel!.sink != null) {
      try {
        _channel!.sink.add("stop");
        print("Calibrazione iniziato con successo.");
        calibration = false;
        detect = false;
      } catch (e) {
        print("Errore nell'invio del messaggio di Detect: $e");
      }
    }
  }

  Future<void> sendVideo(List<int> imageData) async {
    if (_channel != null && _channel!.sink != null) {
      try {
        // Stampe di debug
        //print("Length of sent data: ${imageData.length}");
        //print("Type of sent data: ${imageData.runtimeType}");
        //print("First 10 elements of sent data: ${imageData.sublist(0, 10)}");

        // Send the binary data directly to the server without JSON
        _channel!.sink.add(imageData);
        //count++;
        //print("Video: ");
        //print(count);
      } catch (e) {
        print("Error sending data: $e");
      }
    } else {
      throw WebSocketChannelException("The connection was not established!");
    }
  }
}
