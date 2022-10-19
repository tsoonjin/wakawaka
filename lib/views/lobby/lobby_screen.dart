import 'package:flutter/material.dart';
import './widgets/post_overview.dart';
import './widgets/post_list.dart';
import 'package:waka/models/post.dart';
import 'package:waka/services/game_service.dart';
import 'package:waka/view_models/realtime_game_provider.dart';

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
