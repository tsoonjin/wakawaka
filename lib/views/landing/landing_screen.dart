import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waka/view_models/realtime_game_provider.dart';

class LandingScreen extends StatefulWidget {
  final RealTimeGameProvider provider;
  const LandingScreen({Key? key, required this.provider}) : super(key: key);

  @override
  LandingScreenState createState() {
    return LandingScreenState();
  }
}

class LandingScreenState extends State<LandingScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

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
                        controller: usernameController,
                        validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Thou shall not enter without a name";
                            }
                            return (value.length > 12) ? "Please limit your name to 12 char" : null;
                        },
                        decoration: const InputDecoration(
                                        icon: Icon(Icons.person),
                                        border: UnderlineInputBorder(),
                                        labelText: 'Enter your username',
                                    ),
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
                        widget.provider.connectServer(usernameController.text);
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
