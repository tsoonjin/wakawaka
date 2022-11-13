import 'dart:async';
import 'package:flutter/material.dart';
import 'package:waka/models/player.dart';
import 'package:waka/models/gameplay_response.dart';
import 'package:waka/view_models/realtime_game_provider.dart';

class GameLobbyScreen extends StatefulWidget {
  final RealTimeGameProvider provider;
  const GameLobbyScreen({Key? key, required String roomName, required this.provider}) : super(key: key);

  @override
  GameLobbyScreenState createState() {
    return GameLobbyScreenState();
  }
}

class GameLobbyScreenState extends State<GameLobbyScreen> {
  final formKey = GlobalKey<FormState>();
  Player player1 = Player(name: "Bob", score: 0, health: 3);
  Player player2 = Player(name: "Alice", score: 0, health: 3);
  String timeLeft = "60";
  Timer? countdownTimer;
  Duration? initialTimer;

  TextStyle kCustomText({
      double fontSize = 16.0,
      Color color = Colors.black,
      FontWeight fontWeight = FontWeight.normal
  }) =>
  TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight
  );

   void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = initialTimer != null
        ? initialTimer!.inSeconds - reduceSecondsBy
        : 60;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        initialTimer = Duration(seconds: seconds);
      }
    });
  }

   String _getWinner(Player player1, Player player2) {
       if (player1.health == 0) {
           return player2.name;
       }
       if (player2.health == 0) {
           return player1.name;
       }
       if (player1.score == player2.score) {
           return "";
       }
       return player1.score > player2.score ? player1.name : player2.name;
   }

  void _tapped(String cell, int idx) {
      widget.provider.sendGameAction(player1.name, idx);
      setState(() {
          if (cell == 'm') {
              player1 = Player(name: player1.name, score: player1.score + 1, health: player1.health);
          }
          if (cell == 'r') {
              player1 = Player(name: player1.name, score: player1.score, health: player1.health - 1);
          }
      });
  }

  @override
  void initState() {
    widget.provider.startGame("Bob");
    initialTimer = const Duration(seconds: 60);
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
      super.initState();
  }

  Widget _buildCell(String value) {
      if (value != "m" && value != "r") {
          return Text(
              value,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
              ),
          );
      }
      String imagePath = value == "m" ? "assets/mole.png" : "assets/rabbit.png";
      return Image.asset(
          imagePath,
          height: 100,
          width: 100
      );
  }

  Widget _buildGrid() {
    return Expanded(
      flex: 8,
      child: Container(
      width: 800,
      height:800,
      child: StreamBuilder<GamePlayResponse>(
        stream: widget.provider.gameStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && initialTimer != null && initialTimer! >= const Duration(seconds: 60)) {
            return Center(
                child: GridView.builder(
                            padding: const EdgeInsets.all(32),
                            itemCount: 9,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    child: Container(
                                               decoration:
                                               BoxDecoration(border: Border.all(color: Colors.grey[700]!)),
                                               child: Center(
                                                   child: _buildCell(index == 4 ? "Start": '')
                                               ),
                                           ),
                                );
                            })
            );
          }
          if (snapshot.connectionState == ConnectionState.done || player1.health == 0 || player2.health == 0) {
             String winner = _getWinner(player1, player2);
             String endGameMsg = "Game Over\n${winner == "" ? "It is a draw !": "Winner is $winner"}";
            return Center(
              child: GridView.builder(
                            padding: const EdgeInsets.all(32),
                            itemCount: 9,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    child: Container(
                                               decoration:
                                               BoxDecoration(border: Border.all(color: Colors.grey[700]!)),
                                               child: Center(
                                                   child: _buildCell(index == 4 ? endGameMsg: '')
                                               ),
                                           ),
                                );
                            })
            );
          }
            if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                return
                        GridView.builder(
                            padding: const EdgeInsets.all(32),
                            itemCount: 9,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                        _tapped(snapshot.data?.board[index] ?? '', index);
                                    },
                                    child: Container(
                                               decoration:
                                               BoxDecoration(border: Border.all(color: Colors.grey[700]!)),
                                               child: Center(
                                                   child: _buildCell(snapshot.data?.board[index] ?? '')
                                               ),
                                           ),
                                );
                            });
            }
            return Center(
                child: GridView.builder(
                            padding: const EdgeInsets.all(32),
                            itemCount: 9,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    child: Container(
                                               decoration:
                                               BoxDecoration(border: Border.all(color: Colors.grey[700]!)),
                                               child: Center(
                                                   child: _buildCell("")
                                               ),
                                           ),
                                );
                            })
            );
        }
      )
    )
    );
  }

  Widget _buildPointsTable(Player player1, Player player2, Duration timer) {
    return Expanded(
        flex: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player1.name,
                    style: kCustomText(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      children: List.generate(player1.health, (_) =>
                          const Icon(Icons.favorite,
                              color: Colors.pink,
                              size: 24.0,
                          )
                      )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    player1.score.toString(),
                    style: kCustomText(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  )]
                  )
                          ),
                  Column(
                  children: [
                      Text(
                          "Wackamole",
                          style: kCustomText(
                              color: Colors.black,
                              fontSize: 42.0,
                              fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                          timer.inSeconds.toString(),
                          style: kCustomText(
                              color: Colors.black,
                              fontSize: 42.0,
                              fontWeight: FontWeight.bold),
                      )
                  ]),
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player2.name,
                    style: kCustomText(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      children: List.generate(player2.health, (_) =>
                          const Icon(Icons.favorite,
                              color: Colors.pink,
                              size: 24.0,
                          )
                      )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    player2.score.toString(),
                    style: kCustomText(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  )]
              ),
            )
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFF2EAE0);

    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: backgroundColor
        ),
        child: Column(
            children: [
                _buildPointsTable(player1, player2, initialTimer ?? const Duration(seconds: 60)),
                _buildGrid()
            ],
        )
    ));
  }
}
