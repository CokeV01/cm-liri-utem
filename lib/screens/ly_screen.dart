import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ly_finder.dart';
import 'package:flutter_application_1/widgets/my_bar.dart';
import 'package:flutter_application_1/widgets/my_title.dart';
import 'package:genius_lyrics/genius_lyrics.dart';
import 'package:logger/logger.dart';

class LyScreen extends StatefulWidget{
  const LyScreen({super.key});

  @override
  _LyScreen createState() => _LyScreen();
}

class _LyScreen extends State<LyScreen>{

  final textControl1 = TextEditingController();
  final textControl2 = TextEditingController();
  static final _logger = Logger();
  bool _isLoading = false;

  ///Función asincrona que busca la cancion deseada y retorna una variable Song
  ///Esta variable song contiene datos relevantes sobre la cancion como el album,
  ///el artista, y mas importante aun los lyrics de la canción.
  Future<Song?> _searchSong(String art, String title) async {
    Genius genius = Genius(accessToken: "cRzLItZvdT5_R9a7xhCwfmuxELi8Dk6zKV5yrzvdBA-PdUpBifUenRMdNGiBk4U7");
    setState(() {
      _isLoading = true;
    });
    ///Tarea de Carga, busqueda de cancion
    Song? song = (await genius.searchSong(artist: textControl1.text, title: textControl2.text));
    setState(() {
      _isLoading = false;
    });
    return song;
  }

  @override
  Widget build(BuildContext context) {

    ///Al cargar la canción la pantalla es bloqueada hasta que se muestre una respuesta
    ///si es correcta la busqueda mostrara los lyrics en la siguiente ventana
    return Scaffold(
      appBar: const MyBar(),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: LyTitle()),
              const SizedBox(height: 15),

              //Texto del Nombre del Artista
              Center(child: SizedBox(
                height: 45,
                width: 350,
                child: TextField(
                  controller: textControl1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Nombre del Artista",
                    contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
                    suffixIcon: IconButton(onPressed: (){
                      textControl1.clear();
                    }, icon: const Icon(Icons.clear))
                  ),
                ),
              )),
              const SizedBox(height: 15),
              //Texto del Nombre de la canción
              Center(child: SizedBox(
                height: 45,
                width: 350,
                child: TextField(
                  controller: textControl2,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Nombre de la Canción",
                    contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
                    suffixIcon: IconButton(onPressed: (){
                      textControl2.clear();
                    }, icon: const Icon(Icons.clear))
                  ),
                ),
              )),
              const SizedBox(height: 10,),
              //Boton Buscar Cancion
              Center(child: ElevatedButton(
                onPressed: () async {
                  if(textControl1.text.isEmpty || textControl2.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Introduce el Artista y la cancion porfavor"))
                    );
                  }
                  else{
                    Song? song = await _searchSong(textControl1.text, textControl2.text);
                    if (song != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LyFinder(cancion: song)));
                    }
                  }
                },
                child: const Text("Buscar Lyrics"),
              ))
            ],
          ),
          //Pantalla Bloqueada
          if(_isLoading)
            ModalBarrier(
              dismissible: false,
              color: Colors.black.withOpacity(0.3)
            ),
          //Circulo de Carga
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),

    );
  }
}