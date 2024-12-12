import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

main() async {
  var channel = IOWebSocketChannel.connect(Uri.parse('ws://192.168.1.32:5000'));

  channel.stream.listen((message) {
    print(message);
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
}
