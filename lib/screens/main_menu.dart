import 'dart:io';

import 'package:flutter_application_1/widgets/exit_conf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/fav_songs.dart';
import 'package:flutter_application_1/screens/ly_screen.dart';
import 'package:flutter_application_1/screens/options.dart';
import 'package:flutter_application_1/widgets/my_bar.dart';
import 'package:flutter_application_1/widgets/my_buttons.dart';
import 'package:flutter_application_1/widgets/my_title.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: const MyBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: LyTitle()),
              const SizedBox(
                height: 100.0,
              ),
              const LyButtons(texto: 'Buscar Lyrics', route: LyScreen()),
              const SizedBox(height: 16.0),
              const LyButtons(texto: 'Tus Lyrics', route: FavSongs()),
              const SizedBox(height: 16.0),
              const LyButtons(texto: 'Opciones', route: Options()),
              const SizedBox(height: 100.0),
              ElevatedButton(
                onPressed: () {
                  Conf exit = Conf();
                  exit.showExitConfirmationDialog(context);
                },
                child: const Text('Salir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


