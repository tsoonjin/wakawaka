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
            decoration:
            const BoxDecoration(
                color: backgroundColor
            ),
            child:
            FractionallySizedBox(
                alignment: Alignment.center,
                heightFactor: 0.3,
                widthFactor: 0.5,
                child:
                MouseRegion(
                    cursor:  mousePos != Offset.zero ? SystemMouseCursors.none : SystemMouseCursors.basic,
                    onHover: (eve) {
                        setState(() {
                            mousePos = eve.position;
                        });
                    },
                    onExit: (eve) {
                        isInRegion = false;
                    },
                    onEnter: (eve) {
                        isInRegion = true;
                    },
                    child:
                    Stack(
                        children: [
                            Container(
                                decoration:
                                const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.red
                                ),
                                // child:
                                // Form(
                                //     key: formKey,
                                //     child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //         children: [
                                //             SizedBox(
                                //                 height: 240,
                                //                 width: 240,
                                //                 child: Image.asset(
                                //                     "assets/mole.png",
                                //                     height: 100,
                                //                     width: 100
                                //                 )
                                //             ),
                                //             const SizedBox(height: 32),
                                //             const SizedBox(height: 32),
                                //             ElevatedButton(
                                //                 style: ElevatedButton.styleFrom(
                                //                     primary: Colors.white
                                //                 ),
                                //                 onPressed: () {
                                //                     if (formKey.currentState!.validate()) {
                                //                         ScaffoldMessenger.of(context).showSnackBar(
                                //                             const SnackBar(content: Text('Processing Data')),
                                //                         );
                                //                         widget.provider.connectServer(usernameController.text);
                                //                         GoRouter.of(context).push('/games');
                                //                     }
                                //                 },
                                //                 child: const Text('Enter'),
                                //             ),
                                //         ]
                                //     )
                                // )
                            ),
                            if (isInRegion) ...[Positioned(
                                    left: mousePos.dx - 500,
                                    top: mousePos.dy - 600,
                                    child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                                            border: Border.all(
                                               width: 5,
                                               color: Colors.blue,
                                               style: BorderStyle.solid)),
                                      )
                                )]
                        ]
                    )
                )
            )
        )
    );
  }
}
