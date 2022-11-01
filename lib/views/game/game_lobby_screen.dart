import 'package:flutter/material.dart';
import 'package:waka/models/player.dart';
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
  final Player player1 = Player(name: "Bob", score: 0, health: 3);
  final Player player2 = Player(name: "Alice", score: 0, health: 3);
  String timeLeft = "60";
  final List<String> _grid = [
    '',
    'm',
    '',
    '',
    '',
    '',
    '',
    'r',
    '',
  ];

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

  void _tapped(int index) {
      print("Tapped $index");
  }

  Widget _buildCell(String value) {
      if (value == "") {
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
      child: GridView.builder(
          padding: const EdgeInsets.all(32),
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _tapped(index);
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[700]!)),
                child: Center(
                    child: _buildCell(_grid[index])
                ),
              ),
            );
          }),
    )
            );
  }

  Widget _buildPointsTable(Player player1, Player player2) {
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
                          timeLeft,
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
                _buildPointsTable(player1, player2),
                _buildGrid()
            ],
        )
    ));
  }
}
