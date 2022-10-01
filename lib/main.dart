import 'package:waka/views/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);


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
  final _router = GoRouter(
      routes: [
          GoRoute(path: '/', builder: (context, state) => const LandingScreen()),
      ],
  );
}
