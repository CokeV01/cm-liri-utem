import 'package:flutter/material.dart';

class MyTitle extends State<LyTitle> {
  @override
  Widget build(BuildContext context) {
    return const Text('LiryFind',
        style: TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'LobsterFont',
        ));
  }
}

class LyTitle extends StatefulWidget {
  const LyTitle({
    super.key,
  });
  @override
  State<StatefulWidget> createState() => MyTitle();
}
