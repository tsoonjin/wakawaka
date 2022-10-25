import 'dart:async';
import 'dart:convert';

import 'package:waka/models/game_socket_request.dart';
import 'package:waka/models/game_socket_response.dart';
import 'package:waka/models/room_socket_response.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Manages opening and closing the sockets for the
/// two different sockets: ETH socker and BTC socket
class RealTimeGameProvider {
  late final WebSocketChannel _gameServerWebSocket;

  RealTimeGameProvider()
      : _gameServerWebSocket = WebSocketChannel.connect(
          Uri.parse('ws://localhost:8080/connect'),
        );

  Stream<RoomSocketResponse> get serverStream => _gameServerWebSocket.stream
      .map<RoomSocketResponse>(
          (value) => RoomSocketResponse.fromJson(jsonDecode(value)));

  Stream<GameSocketResponse> generateNumbers = (() async* {
      await Future<void>.delayed(const Duration(seconds: 2));

      for (int i = 1; i > 0; i++) {
          await Future<void>.delayed(const Duration(seconds: 1));
          yield GameSocketResponse.fromJson(jsonDecode('{"message": "Room $i"}'));
      }
  })();

  void connectServer(String username) {
    _gameServerWebSocket.sink.add(
      jsonEncode(
        GameSocketRequest(
           "connect",
           { "name":  username}
        ).toJson(),
      ),
    );
  }

  void joinGame(String roomName) {
    _gameServerWebSocket.sink.add(
      jsonEncode(
        GameSocketRequest(
            "join", { "roomName": roomName }
        ).toJson(),
      ),
    );
  }

  void readyGame(int roomId) {
    _gameServerWebSocket.sink.add(
      jsonEncode(
        GameSocketRequest(
            "ready", { "roomId": roomId }
        ).toJson(),
      ),
    );
  }

  void closeServer() {
    _gameServerWebSocket.sink.close();
  }
}
