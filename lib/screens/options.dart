import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/my_bar.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyBar(),
    );
  }
}
