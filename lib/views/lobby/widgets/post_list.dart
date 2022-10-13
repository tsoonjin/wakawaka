import 'package:flutter/material.dart';
import 'package:waka/models/post.dart';
import 'package:waka/views/lobby/widgets/post_overview.dart';

class PostList extends StatelessWidget {

  final List<Post> posts;
  final bool isLoading;

  const PostList({Key? key, required this.posts, required this.isLoading}):  super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: const Text("Blog App"), centerTitle: true,),
          body: buildPostsView(),
      );
  }

  Widget buildPostsView() {
      if (posts.isEmpty) {
          if (isLoading) {
              return const Center(
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                  ));
          }
      }
      return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
              final Post post = posts[index];
              return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: PostItem(title: post.title, body: post.description)
              );
          });
  }
}
