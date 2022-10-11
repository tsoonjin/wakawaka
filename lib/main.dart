import 'package:waka/view_models/realtime_game_provider.dart';
import 'package:waka/views/landing/landing_screen.dart';
import 'package:waka/views/lobby/lobby_screen.dart';
import 'package:waka/views/game/game_lobby_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  late final RealTimeGameProvider _provider;
  App({Key? key}) : _provider = RealTimeGameProvider(), super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wakawaka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  late final _router = GoRouter(
      routes: [
          GoRoute(path: '/', builder: (context, state) => LandingScreen(provider: _provider)),
          GoRoute(
              path: '/games',
              builder: (context, state) => const LobbyScreen(),
          ),
           GoRoute(
        path: '/games/:id',
        builder: (context, state) {
          return GameLobbyScreen(
            key: state.pageKey,
            index: int.parse(state.params['id'] ?? '0')
          );
        },
      ),
      ],
  );
}
