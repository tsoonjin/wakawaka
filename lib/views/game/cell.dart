import 'package:flutter/material.dart';

class Cell extends StatefulWidget {
  final String hitImagePath;
  final String initImagePath;
  const Cell({Key? key, required this.initImagePath, required this.hitImagePath}): super(key: key);

  @override
  _CellState createState() => _CellState();

}

class _CellState extends State<Cell> {
  bool isHit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            child: GestureDetector(
              onTap: () {
                  setState(() {
                      isHit = !isHit;
                  });
              },
              child: CircleAvatar(
                maxRadius: 20.0,
                child: Image.asset(isHit ? widget.hitImagePath : widget.initImagePath),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
