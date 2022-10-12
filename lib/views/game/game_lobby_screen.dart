import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameLobbyScreen extends StatefulWidget {
  const GameLobbyScreen({Key? key, required int index}) : super(key: key);

  @override
  GameLobbyScreenState createState() {
    return GameLobbyScreenState();
  }
}

class GameLobbyScreenState extends State<GameLobbyScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFF2EAE0);

    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: backgroundColor
        ),
        child: FractionallySizedBox(
            alignment: Alignment.center,
            heightFactor: 0.3,
            widthFactor: 0.5,
            child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.orange,
            ),
            child:
        Form(
            key: formKey,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 240,
              width: 240,
              child: Image.network('https://freesvg.org/img/mole2.png'),
            ),
            const SizedBox(height: 32),
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(300, 50)),
                    child:
                    TextFormField(
                        validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Thou shall not enter without a name";
                            }
                            return (value.length > 12) ? "Please limit your name to 12 char" : null;
                        },
                        decoration: const InputDecoration(
                                        icon: Icon(Icons.person),
                                        border: UnderlineInputBorder(),
                                        labelText: 'Enter your username',),
                    ))),
            const SizedBox(height: 32),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white
                ),
                onPressed: () {
                    if (formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                        );
                        GoRouter.of(context).push('/games');
                    }
                },
                child: const Text('Enter'),
            ),
            ],
        ),
        )
      ))),
    );
  }
}