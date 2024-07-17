import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/access_list.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/services/google_service.dart';
import 'package:flutter_application_1/widgets/my_bar.dart';
import 'package:flutter_application_1/widgets/my_buttons.dart';

import '../widgets/exit_conf.dart';


class Options extends StatefulWidget{
  const Options({super.key});
  @override
  _Options createState() => _Options();
}

class _Options extends State<Options>{

  Conf confi = Conf();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Boton para desloeguearse de la applicacion
            ElevatedButton(onPressed: () async {
              bool conf = await confi.showConfirmationDialog(context, "Cerrando Sesión", "¿Estas seguro que quieres cerrar sesión?");
              if (conf){
                GoogleService.logOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              }
            }, child: const Text("Cerrar Sesión de Google")),
            SizedBox(height: 5),
            ///Boton para la lista de accesos del servicio REST
            const LyButtons(texto: "Lista de accesos a la aplicación", route: AccessList())
          ],
        )
      )
    );
  }
}
