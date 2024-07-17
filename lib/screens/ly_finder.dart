import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/my_fav_button.dart';
import 'package:genius_lyrics/genius_lyrics.dart';

class LyFinder extends StatefulWidget{
  final Song cancion;
  const LyFinder({super.key, required this.cancion});
  @override
  _LyFinder createState() => _LyFinder();
}

class _LyFinder extends State<LyFinder>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyFavBar(cancion: widget.cancion),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  /// Se despliega el titulo de la cancion
                  widget.cancion.title ?? 'Canción no encontrada',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'LobsterFont',
                  ),
                )
              ),
              const SizedBox(height: 2),
              Text(
                /// Se despliega el nombre del artista de la canción
                widget.cancion.artist ?? 'Artista no encontrado',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: 'LobsterFont'
                ),
              ),
              const SizedBox(height: 50),
              Text(
                /// Se despliegan las letras de la canción
                widget.cancion.lyrics ?? '',
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontFamily: 'Geist',
                  )
              )
            ],
          ),

        )
      )
    );
  }

}


