import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GamePlayScreen extends StatelessWidget {
  const GamePlayScreen({Key? key}) : super(key: key);

  void _onExploreButtonTap(BuildContext context) =>
      GoRouter.of(context).push('/colors');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: Colors.lightBlue
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
              width: 180,
              child: Image.asset('assets/dash.png'),
            ),
            const SizedBox(height: 32),
            Text(
              'Game is in play',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: () => _onExploreButtonTap(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                ),
                child: const Text('GO TO EXPLORE PAGE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
