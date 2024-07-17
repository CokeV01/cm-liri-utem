import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/my_bar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/my_buttons.dart';
import 'favlir_screen.dart';

class FavSongs extends StatefulWidget{
  const FavSongs({super.key});

  @override
  _FavSongs createState() => _FavSongs();

}

class _FavSongs extends State<FavSongs>{

  List<FileSystemEntity> songs = [];
  final Logger _logger = Logger();
  final TextEditingController _searchController = TextEditingController();
  List<FileSystemEntity> _filteredFiles = [];


  Future<void> loadSongs() async{
    final dir = await getApplicationDocumentsDirectory();
    final folderPath = Directory('${dir.path}/lyrics');

    if(await folderPath.exists()){
      final files = folderPath.listSync();
      setState(() {
        songs = files;
        _filteredFiles = files;
      });
      _logger.d("Canciones Cargadas!!!");
    }else{
      await folderPath.create();
    }
  }

  void _filterFiles(){
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredFiles = songs.where((file){
        String fileName = file.path.split('/').last.toLowerCase();
        return fileName.contains(query);
      }).toList();
    });
  }

  //Liberación de memoria
  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  //Procesos de inicio de screen
  @override
  void initState(){
    super.initState();
    _searchController.addListener(_filterFiles);
    loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyBar(),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Buscar",
              border: OutlineInputBorder()
            ),
          ),
          ),
          const SizedBox(height: 10),
          ///Menu hecho para encontrar las letras favoritas de manera local,
          ///estas letras se guardan dentro del dispositivo para luego
          ///consultarlas y desplegarlas tal como en la busqueda de letras

          Expanded(child: _filteredFiles.isEmpty ? const Center(child: CircularProgressIndicator()) : ListView.builder(
            itemCount: _filteredFiles.length,
              itemBuilder: (context, index){
                final sang = _filteredFiles[index];
                return Padding(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
                child: LyButtons(texto: sang.path.split('/').last, route: FavlirScreen(song: sang)),
              );
            })
          )
        ],
      )
    );
  }
}