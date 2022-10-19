import 'package:flutter/material.dart';
import 'package:waka/models/post.dart';
import 'package:waka/view_models/realtime_game_provider.dart';

class PostItem extends StatelessWidget {

  final String title;
  final String body;
  final Color? bgColor;
  final RealTimeGameProvider provider;
  final Function updateCurrentPost;

  const PostItem({Key? key, this.bgColor, required this.updateCurrentPost, required this.title, required this.body, required this.provider}): super(key: key);

  @override
  Widget build(BuildContext context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        child: Container(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
          height: 300,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: bgColor ?? const Color(0XFF8338EC)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 36,
                      fontWeight: FontWeight.bold
                  ),),
                const SizedBox(height: 10,),
                Text(body,
                  style: const TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: Colors.white
                  ),),
                const SizedBox(height: 32),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white
                    ),
                    onPressed: () {
                        provider.joinGame(title);
                        updateCurrentPost(Post(id: 1, title: title, description: body));
                    },
                    child: const Text('Join'),
                ),
                    ],
                )
              ],
            ),
          ),
        )
    );
  }
}
