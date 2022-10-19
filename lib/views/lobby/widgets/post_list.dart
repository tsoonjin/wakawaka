import 'package:flutter/material.dart';
import 'package:waka/models/post.dart';
import 'package:waka/views/lobby/widgets/post_overview.dart';
import 'package:waka/services/game_service.dart';
import 'package:waka/view_models/realtime_game_provider.dart';

class PostList extends StatefulWidget {
  final Function updateCurrentPost;
  final RealTimeGameProvider provider;

  const PostList({Key? key, required this.provider, required this.updateCurrentPost}):  super(key: key);

  @override
  PostListState createState() {
    return PostListState();
  }
}

class PostListState extends State<PostList> {
    int pageNumber = 1;
    late List<Post> _posts;
    late bool _isLoading;
    GameService gameService = GameService();

    Future<void> fetchData() async {
        List<Post> postList = await gameService.fetchPosts(pageNumber: pageNumber);
        setState(() {
            _isLoading = false;
            _posts.addAll(postList);
            pageNumber ++;
        });
    }

    @override
    void initState() {
        super.initState();
        _posts = [];
        _isLoading = true;
        fetchData();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: buildPostsView(),
        );
    }

  Widget buildPostsView() {
      if (_posts.isEmpty) {
          if (_isLoading) {
              return const Center(
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                  ));
          }
      }
      return ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (context, index) {
              if (index == _posts.length - 1) {
                  fetchData();
              }
              if (index == _posts.length) {
                return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ));
              }
              final Post post = _posts[index];
              return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: index % 2 == 0 ? PostItem(provider: widget.provider, updateCurrentPost: widget.updateCurrentPost, title: post.title, body: post.description): PostItem(provider: widget.provider, updateCurrentPost: widget.updateCurrentPost, title: post.title, body: post.description, bgColor: Colors.red)
              );
          });
  }
}

