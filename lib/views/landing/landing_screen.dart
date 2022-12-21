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
  Offset mousePos = Offset.zero;
  bool isInRegion = false;

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
            child:  MouseRegion(
        cursor:  mousePos != Offset.zero ? SystemMouseCursors.none : SystemMouseCursors.basic,
          onHover: (eve) {
            setState(() {
              mousePos = eve.position;
            });
          },
          onEnter: (eve) {
            isInRegion = true;
          },
          child: Stack(
                     children: [Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
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
              child: Image.asset(
                  "assets/mole.png",
                  height: 100,
                  width: 100
              )
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
      ),
 Positioned(
         left: mousePos.dx - 100,
         top: mousePos.dy - 100,
         child: Container(
           height: 200,
           width: 200,
           decoration: BoxDecoration(
               borderRadius: const BorderRadius.all(Radius.circular(100)),
               border: Border.all(
                   width: 5,
                   color: Colors.red,
                   style: BorderStyle.solid)),
          ),
       )
        ]))
        )
    ));
  }
}
