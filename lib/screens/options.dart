import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/services/google_service.dart';
import 'package:flutter_application_1/widgets/my_bar.dart';


class Options extends StatefulWidget{
  const Options({super.key});
  @override
  _Options createState() => _Options();
}

class _Options extends State<Options>{
  bool? _buttonValue;

  void _onButtonPressed(bool value){
    setState(() {
      _buttonValue = value;
    });
  }

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
            ElevatedButton(onPressed: (){
              GoogleService.logOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }, child: const Text("Cerrar Sesión de Google"))
          ],
        )
      )
    );
  }
}
