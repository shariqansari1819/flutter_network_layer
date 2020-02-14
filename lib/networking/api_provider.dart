import 'dart:convert';
import 'dart:io';
import 'package:flutter_network_layer/networking/custom_exception.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl = "https://api.chucknorris.io/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection!");
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        return BadRequestException(response.body.toString());
      case 401:
      case 403:
        return UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException(
            "Error occured while communication with server with status code ${response.statusCode}");
    }
  }
}
