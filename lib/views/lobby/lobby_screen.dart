import 'package:flutter/material.dart';
import './widgets/post_overview.dart';
import './widgets/post_list.dart';
import 'package:waka/models/post.dart';
import 'package:waka/services/game_service.dart';

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
  late bool _loading;
  late List<Post> _posts;
  GameService gameService = GameService();


  Future<void> fetchData() async {
    List<Post> postList = await gameService.fetchPosts(pageNumber: 1);
    setState(() {
        _loading = false;
        _posts = postList;
    });
  }

  @override
  void initState() {
      super.initState();
      _posts = [];
      _loading = true;
      fetchData();
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
                child: PostList(posts: _posts, isLoading: _loading)
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
