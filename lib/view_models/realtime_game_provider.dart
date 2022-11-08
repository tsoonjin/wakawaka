import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:waka/models/game_socket_request.dart';
import 'package:waka/models/game_socket_response.dart';
import 'package:waka/models/room_socket_response.dart';
import 'package:waka/models/gameplay_response.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Manages opening and closing the sockets for the
/// two different sockets: ETH socker and BTC socket
class RealTimeGameProvider {
  late final WebSocketChannel _gameServerWebSocket;
  final streamController = StreamController.broadcast();

  RealTimeGameProvider()
      : _gameServerWebSocket = WebSocketChannel.connect(
          Uri.parse('ws://localhost:8080/connect'),
      ) {
        streamController.addStream(_gameServerWebSocket.stream);
      }

  Stream<RoomSocketResponse> get serverStream {
    return streamController.stream
      .map<RoomSocketResponse>(
          (value) => RoomSocketResponse.fromJson(jsonDecode(value)));
  }


  Stream<GamePlayResponse> generateBoard = (() async* {
      bool toggle = false;
      for (int i = 60; i >= 0; i--) {
          print("Still counting $i");
          await Future<void>.delayed(const Duration(seconds: 1));
          String state = "RUNNING";
          Map<String, int> score = {
              "Bob": 0,
              "Alice": 0
          };
          Map<String, int> health = {
              "Bob": 3,
              "Alice": 3
          };
          List<String> board = [
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
          ];
          int moleIdx = Random().nextInt(9);
          int rabbitIdx = Random().nextInt(9);
          while (rabbitIdx == moleIdx) {
            rabbitIdx = Random().nextInt(9);
          }
          if (toggle) {
              board[moleIdx] = 'm';
              board[rabbitIdx] = 'r';
          }
          if (i == 0) {
              state = 'GAME_OVER';
          }
          toggle = !toggle;
          yield GamePlayResponse(i, score, health, state, board);
      }
  })();


  Stream<GameSocketResponse> generateNumbers = (() async* {
      await Future<void>.delayed(const Duration(seconds: 2));

      for (int i = 1; i > 0; i++) {
          await Future<void>.delayed(const Duration(seconds: 1));
          yield GameSocketResponse.fromJson(jsonDecode('{"message": "Room $i"}'));
      }
  })();

  void sendGameAction(String username, int hitIdx) {
    _gameServerWebSocket.sink.add(
      jsonEncode(
        GameSocketRequest(
           "send",
           { "name":  username, "hit": hitIdx}
        ).toJson(),
      ),
    );
  }

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
