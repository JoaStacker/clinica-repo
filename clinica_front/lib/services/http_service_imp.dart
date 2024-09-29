
// ignore_for_file: constant_identifier_names

import 'package:http/http.dart' as http;

class HttpServiceImp{
  HttpServiceImp();
  final http.Client client = http.Client();

  static const String _SCHEME = 'http';
  static const String _BASE_URL = 'localhost';
  static const int _PORT = 5146;

  static Uri getUrl(
    String service, {
    Map<String, dynamic>? queryParameters,
    int? port,
  }) {

    return Uri(
      scheme: _SCHEME,
      host: _BASE_URL,
      port: _PORT,
      queryParameters: queryParameters,
      path: service,
    );
  }

  Future<http.Response> get(String service, {Map<String, dynamic>? queryParameters}) {
    return client.get(
      getUrl(
        service,
        queryParameters: queryParameters,
      ),
      headers: {
        'Access-Control-Allow-Origin': '*', // This is usually set on the server
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS', // Allow methods
        'Access-Control-Allow-Headers': 'Content-Type, Authorization', // Allow headers
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'withCredentials': 'true'
      }
    );
  }

}