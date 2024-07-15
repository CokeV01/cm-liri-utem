import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/exit_conf.dart';
import 'package:genius_lyrics/models/song.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';


class MyFavBar extends StatefulWidget implements PreferredSizeWidget{
  final Song cancion;
  final Conf confi = Conf();
  MyFavBar({super.key, required this.cancion});

  @override
  _MyFavButton createState() => _MyFavButton();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyFavButton extends State<MyFavBar>{
  static final _logger = Logger();

  void saveSong({required Song song})async{
    try{
      final dir = await getApplicationDocumentsDirectory();
      final lyrPath = "${dir.path}/lyrics/${song.artist} - ${song.title}";
      final lyrFile = File(lyrPath);

      if (lyrFile.existsSync()){
        _logger.d("La cancion ya esta guardada");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('La cancion ya esta en tu lista :|'))
        );
      }
      else{
        song.saveLyrics(fileName: lyrPath, overwite: true);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cancion Agregada :D'))
        );
      }
    }catch(e){
      _logger.d(e);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo Agregar'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 52, 63, 211),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(onPressed: () async {
          bool result = await widget.confi.showConfirmationDialog(context, "Agregar canción", "¿Quieres agregar esta canción?");
          if(result){
            saveSong(song: widget.cancion);
          }
        }, icon: const Icon(Icons.star_border),color: Colors.black)
      ],
    );
  }
}