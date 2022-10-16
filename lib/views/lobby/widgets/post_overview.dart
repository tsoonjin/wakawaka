import 'package:flutter/material.dart';
import 'package:waka/services/game_service.dart';

class PostItem extends StatelessWidget {

  final String title;
  final String body;

  const PostItem({Key? key, required this.title, required this.body}): super(key: key);

  @override
  Widget build(BuildContext context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        child: Container(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
          height: 300,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0XFF8338EC)
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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white
                    ),
                    onPressed: () {
                        print("Join game");
                    },
                    child: const Text('Join'),
                ),
              ],
            ),
          ),
        )
    );
  }
}
