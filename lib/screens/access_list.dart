import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/google_service.dart';
import 'package:flutter_application_1/services/rest_service.dart';
import 'package:logger/logger.dart';

class AccessList extends StatefulWidget{

  const AccessList({super.key,});

  @override
  _AccessList createState() => _AccessList();

}

class _AccessList extends State<AccessList>{
  RestService res = RestService();
  Logger _logger = Logger();

  String Resp = '';

  @override
  void initState() {
    super.initState();
    _loadResp();
    _logger.i("Cuantas veces ingreso: $Resp");
  }

  Future<void> _loadResp() async{
    String id = await GoogleService.getID();
    String email = await GoogleService.getEmail();

    setState(() async {
      Resp = await res.allAccess(id, email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

          ],
        )
      ),
    );
  }
}