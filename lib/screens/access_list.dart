import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/google_service.dart';
import 'package:flutter_application_1/services/rest_service.dart';
import 'package:flutter_application_1/widgets/my_bar.dart';
import 'package:logger/logger.dart';

class AccessList extends StatefulWidget{

  const AccessList({super.key,});

  @override
  _AccessList createState() => _AccessList();

}

class _AccessList extends State<AccessList>{
  RestService res = RestService();
  String Resp = '';
  bool _respRec = false;
  final Logger _logger = Logger();
  String email = '';
  String id = '';
  int count = 0;

  @override
  void initState() {
    _logger.d("Respuesta: $_respRec");
    super.initState();
    _loadResp();
    _logger.d("Respuesta: $_respRec");


  }

  int countCharacterOccurrences(String text, String character) {
    RegExp regExp = RegExp(character);
    Iterable<RegExpMatch> matches = regExp.allMatches(text);
    return matches.length;
  }

  Future<void> _loadResp() async{
    id = await GoogleService.getID();
    email = await GoogleService.getEmail();
    setState(() {
      _respRec = true;
    });
    Resp = await res.allAccess(id, email);
    count = countCharacterOccurrences(Resp, email);
    setState(() {
      _respRec = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyBar(),
      body:Stack(
        children: [
          SingleChildScrollView(
            child:
                Column(
                  children: [
                        Align(
                          alignment: const FractionalOffset(0.5, 0.5),
                          child: Column(
                            children: [
                              Text(
                                "Correo a revisar: $email",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10.50,
                                  color: Colors.white,
                                  fontFamily: 'Geist',
                                )
                              ),
                              Text(
                                "Numero de ingresos: $count",
                                //textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 10.50,
                                  color: Colors.white,
                                  fontFamily: 'Geist',
                                ),
                              ),
                            ],
                          ),
                        ),
                    const SizedBox(height: 30,),
                    Center(
                      child: Align(
                        alignment: const FractionalOffset(0.5, 0.5),
                        child: Text(Resp,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ),
          if(_respRec)
            ModalBarrier(
                dismissible: false,
                color: Colors.black.withOpacity(0.3)
            ),
          //Circulo de Carga
          if (_respRec)
            const Center(
              child: CircularProgressIndicator(),
            )
        ]
      ),
    );
  }
}