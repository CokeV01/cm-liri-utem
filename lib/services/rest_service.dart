import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/jwt_vo.dart';
import 'package:logger/logger.dart';

class RestService{
  static const String _mime ="application/json";
  static const String _baseUrl = 'https://api.sebastian.cl/Auth';
  static const Map<String, String> _headers ={
    'accept': _mime,
    'X-API-TOKEN': 'sebastian.cl',
    'X-API-KEY': 'aaa-bbb-ccc-ddd',
  };

  static final Logger _logger = Logger();
  static final Dio _client = Dio();

  Future<String> allAccess(String idToken, String email) async{

    _logger.d("Acceso para consulta de ingreso del EMAIL: $email");
    JwtVo vo = JwtVo();
    vo.jwt = idToken;

    String utfEmail = Uri.encodeComponent(email);
    String url = '$_baseUrl/v1/access/all?email=$utfEmail';

    _client.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true
    ));

    Response<String> response = await _client.get(url,
        options: Options(headers: _headers));
    final int status = response.statusCode ?? 400;
    final String jsonResponse = response.data ?? '';

    if(status >= 200 && status < 300){
      _logger.i('Respuesta con codigo $status');
      _logger.i(jsonResponse);
    }else{
      _logger.e("Respuesta Incorrecta con codigo $status");
      _logger.e(jsonResponse);
    }
    return jsonResponse;
  }

  Future<void> access(String idToken) async{
    try {
      _logger.d('Acceso de: $idToken');
      JwtVo vo = JwtVo();
      vo.jwt = idToken;
      const String url = '$_baseUrl/v1/access/login';

      _client.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true
      ));

      Response<String> response = await _client.post(url,
          data: vo.toJson(), options: Options(headers: _headers));
      final int status = response.statusCode ?? 400;
      final String jsonResponse = response.data ?? '';

      if(status >= 200 && status < 300){
        _logger.i('Respuesta con codigo $status');
      }else{
        _logger.e("Respuesta Incorrecta con codigo $status");
        _logger.e(jsonResponse);
      }

    } catch(error, stackTrace){
      _logger.e(error.toString());
      _logger.d(stackTrace.toString());
    }
  }

}


