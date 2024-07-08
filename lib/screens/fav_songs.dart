import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/my_bar.dart';
import 'package:flutter_application_1/widgets/my_title.dart';

class FavSongs extends StatefulWidget{
  const FavSongs({super.key});

  @override
  _FavSongs createState() => _FavSongs();

}

class _FavSongs extends State<FavSongs>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
      ),
    );
  }

}
