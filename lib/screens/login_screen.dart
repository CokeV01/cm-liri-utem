import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_menu.dart';
import 'package:flutter_application_1/services/rest_service.dart';
import 'package:flutter_application_1/widgets/my_title.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/storage_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static final _logger = Logger();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<bool> _handleAuth() async {
    bool auth = false;
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication authentication =
            await account.authentication;
        final String idToken = authentication.idToken ?? '';
        final String accessToken = authentication.accessToken ?? '';

        if (idToken.isNotEmpty && accessToken.isNotEmpty){
          SharedPreferences.getInstance().then((current) {
            current.setString('idToken', idToken);
            current.setString('email', account.email);
            current.setString('name', account.displayName ?? '');
            current.setString('Image', account.photoUrl ?? '');
          });
        }

        auth = (idToken.isNotEmpty || accessToken.isNotEmpty);

        _logger.d(idToken);
        _logger.d(accessToken);
      }
    } catch (error, stackTrace) {
      auth = false;
      _logger.e('Error al iniciar sesión en Google: ${error.toString()}');
      _logger.d(stackTrace.toString(), stackTrace: stackTrace);
    }
    return auth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _handleAuth().then((ok){
                if(ok){
                  StorageService.getValue("idToken").then((jwt){
                    RestService rs = RestService();
                    rs.access(jwt);
                  });
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
    );
  }
}
