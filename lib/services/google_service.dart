import 'package:flutter_application_1/services/rest_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleService {
  static final Logger _logger = Logger();

  static final GoogleSignIn _googleSignIn =
  GoogleSignIn(clientId: '84532805201-9e5cobl301r9avo7mbb6hjj2i0brs86o.apps.googleusercontent.com',
      scopes: ['email', 'profile']);

  static Future<bool> logIn() async {
    bool ok = false;
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        final String idToken = auth.idToken ?? '';
        _logger.d('Google ID token $idToken');

        final String accessToken = auth.accessToken ?? '';
        _logger.d('Google Access Token $accessToken');

        if (idToken.isNotEmpty && accessToken.isNotEmpty) {
          SharedPreferences.getInstance().then((current) {
            current.setString('idToken', idToken);
            current.setString('email', account.email);
            current.setString('name', account.displayName ?? '');
            current.setString('image', account.photoUrl ?? '');
            RestService rs = RestService();
            //rs.allAccess(idToken, account.email);
            rs.access(idToken);
          });
          ok = true;
        }
      }
    } catch (error, stackTrace) {
      ok = false;
      _logger.e(error);
      _logger.d(stackTrace.toString());
    }
    return ok;
  }

  static Future<void> logOut() async {
    try {
      await _googleSignIn.signOut();
      SharedPreferences.getInstance().then((current) {
        current.setString('idToken', '');
        current.setString('email', '');
        current.setString('name', '');
        current.setString('image', '');
      });
      _logger.i('El usuario terminó su sesión');
    } catch (error, stackTrace) {
      _logger.e(error);
      _logger.d(stackTrace.toString());
    }
  }

  static Future<String> getEmail() async{
    String email = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    email =  prefs.getString('email') ?? "no mail";
    return email;
  }

  static Future<String> getID() async{
    String Idtoken = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Idtoken =  prefs.getString('idToken') ?? "no mail";
    return Idtoken;
  }
}