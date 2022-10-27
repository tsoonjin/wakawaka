import 'package:flutter/material.dart';
import './widgets/post_overview.dart';
import './widgets/post_list.dart';
import 'package:waka/models/post.dart';
import 'package:waka/services/game_service.dart';
import 'package:waka/view_models/realtime_game_provider.dart';
import 'package:waka/models/room_socket_response.dart';

class LobbyScreen extends StatefulWidget {
  final RealTimeGameProvider provider;
  const LobbyScreen({Key? key, required this.provider}) : super(key: key);

  @override
  LobbyScreenState createState() {
    return LobbyScreenState();
  }
}

class LobbyScreenState extends State<LobbyScreen> {
  final double breakpoint = 800;
  final int paneProportion = 60;
  Post? _currentPost;
  GameService gameService = GameService();

  void setCurrentPost(Post post) {
      setState(() {
          _currentPost = post;
      });
  }

  @override
  void initState() {
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
  if (breakpoint < MediaQuery.of(context).size.width) {
      return Flex(
        direction: Axis.horizontal,
        children: [
            Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<RoomSocketResponse>(
        stream: widget.provider.serverStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                        snapshot.data!.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    Text(
                        snapshot.data!.state,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                        ),
                    ),
                    Text(
                        'Ready: ${snapshot.data!.readyPlayers.join(', ')}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                        ),
                    ),
                    Text(
                        'Waiting: ${snapshot.data!.waitingPlayers.join(', ')}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                        ),
                    ),
                ]
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const Center(
              child: Text(
                        'No more data',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 24.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
            );
          }

          return const Center(
            child: Text('No data'),
          );
        },
      ),
    ),
          Flexible(
            flex: paneProportion,
            child: Container(
                color: Colors.red,
                child: PostList(updateCurrentPost: setCurrentPost, provider: widget.provider)
            ),
          ),
          Flexible(
            flex: 100 - paneProportion,
            child: Align(
                alignment: Alignment.topCenter,
                child: _currentPost != null ? PostItem(title: _currentPost?.title ?? "No title", body: _currentPost?.description ?? "No description found", updateCurrentPost: setCurrentPost, provider: widget.provider): null
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
