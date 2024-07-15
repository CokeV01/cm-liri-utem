import 'dart:io';
import 'package:flutter/material.dart';

import '../widgets/my_bar.dart';

class FavlirScreen extends StatefulWidget{
  final FileSystemEntity song;
  const FavlirScreen({super.key, required this.song});

  @override
  _FavlirScreen createState() => _FavlirScreen();
}

class _FavlirScreen extends State<FavlirScreen>{

  Future<String> _readFileContent() async{
    try{
      final file = File(widget.song.path);
      return await file.readAsString();
    }catch(e){
      return "Error";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  widget.song.path.split('/').last.split(' - ').first,
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'LobsterFont',
                  ),
                )
              ),
              const SizedBox(height: 2),
              Text(
                widget.song.path.split('/').last.split(' - ').last,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'LobsterFont',
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 50),
              FutureBuilder<String>(
                future: _readFileContent(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError){
                    return const Center(child: Text("Error al leer el archivo"));
                  }else{
                    return Padding(padding: const EdgeInsets.all(16.0),
                    child: Text(snapshot.data ?? '',
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontFamily: 'Geist',
                    )),
                    );
                  }
                }
              )
            ],
          )
        )
      )
    );
  }
}