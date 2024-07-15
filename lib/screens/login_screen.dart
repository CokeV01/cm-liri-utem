import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_menu.dart';
import 'package:flutter_application_1/services/google_service.dart';
import 'package:flutter_application_1/widgets/my_title.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: LyTitle()),
              const SizedBox(
                height: 17.0,
              ),
              ElevatedButton(onPressed: (){
                GoogleService.logIn().then((result){
                  if (result){
                    _logger.d("Autentificado");
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return const MainMenu();
                      },
                    ));
                  }else{
                    _logger.e("Falló la Autenticación");
                  }
                });
              }, child: const Text('Acceder con Google')),
            ],
          ),
        ),
            ),
      );
  }
}
