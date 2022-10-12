import 'dart:async';
import 'dart:convert';

import 'package:waka/models/game_socket_request.dart';
import 'package:waka/models/game_socket_response.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Manages opening and closing the sockets for the
/// two different sockets: ETH socker and BTC socket
class RealTimeGameProvider {
  late final WebSocketChannel _gameServerWebSocket;

  RealTimeGameProvider()
      : _gameServerWebSocket = WebSocketChannel.connect(
          Uri.parse('ws://localhost:8080/connect'),
        );

  Stream<GameSocketResponse> get serverStream => _gameServerWebSocket.stream
      .map<GameSocketResponse>(
          (value) => GameSocketResponse.fromJson(jsonDecode(value)));

  void connectServer(String name) {
    print("Username: $name, State: $_gameServerWebSocket");
    _gameServerWebSocket.sink.add(
      jsonEncode(
        GameSocketRequest(
           name
        ).toJson(),
      ),
    );
  }

  void closeServer() {
    _gameServerWebSocket.sink.close();
  }
}
