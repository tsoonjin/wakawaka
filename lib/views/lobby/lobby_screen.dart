import 'package:flutter/material.dart';
import './widgets/post_overview.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  LobbyScreenState createState() {
    return LobbyScreenState();
  }
}

class LobbyScreenState extends State<LobbyScreen> {
  final double breakpoint = 800;
  final int paneProportion = 60;

  @override
  Widget build(BuildContext context) {
  if (breakpoint < MediaQuery.of(context).size.width) {
      return Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: paneProportion,
            child: Container(
                color: Colors.red
            ),
          ),
          Flexible(
            flex: 100 - paneProportion,
            child: const Align(
                alignment: Alignment.topCenter,
                child: PostItem(title: "Room 1", body: "Battle royale game")
            )
            // child: Container(
            //     color: Colors.lightBlue
            // ),
          ),
        ],
      );
    }
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 100,
          child: Container(
              color: Colors.red
          ),
        ),
      ],
    );
  }}
