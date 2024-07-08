import 'package:flutter/material.dart';

class MyButtons extends State<LyButtons> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.route));
      },
      child: Text(widget.texto),
    );
  }
}

class LyButtons extends StatefulWidget {
  final String texto;
  final Widget route;

  const LyButtons({super.key, required this.texto, required this.route});

  @override
  State<StatefulWidget> createState() => MyButtons();
}
