import 'package:app/VideoStream/VideoStreaming.dart';
import 'package:app/VideoStream/websocket.dart';
import 'package:app/constants/theme.dart';
import 'package:app/diagnostics/diagnostics.dart';
import 'package:app/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final WebSocket _socket = WebSocket();

  int _currentIndex = 1;
  final List<Widget> _children = [Diagnostics(), VideoStream(), Settings()];

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  void dispose() {
    super.dispose();
    disconnect();
  }

  void connect() async {
    _socket.connect();
  }

  void disconnect() async {
    _socket.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTabTapped(1);
        },
        mini: false,
        tooltip: "Registra",
        child: _currentIndex != 1
            ? Icon(FeatherIcons.activity, size: 40, color: Colors.white)
            : Icon(Icons.play_arrow_rounded, size: 50, color: Colors.white),
        elevation: 4.0,
        backgroundColor: AppTheme.mainBlue,
        heroTag: "registra",
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(30.0)), // Bordo arrotondato
          side: BorderSide(color: Colors.white, width: 5.0), // Bordo bianco
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                onTabTapped(0);
              },
              icon: Icon(FeatherIcons.fileText),
              color: _currentIndex == 0
                  ? AppTheme.mainBlue
                  : AppTheme.mainGray, // Cambia colore se selezionato
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                onTabTapped(2);
              },
              icon: Icon(FeatherIcons.settings),
              color: _currentIndex == 2
                  ? AppTheme.mainBlue
                  : AppTheme.mainGray, // Cambia colore se selezionato
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
