import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// A client for making API requests to the backend server.
class APIClient {
  static const String baseUrl = 'https://api.adzuna.com/v1/api/';
  static const String baseUrlDetails = 'https://www.adzuna.com/details/';
  static const String appID = '50aeec5e';
  static const String appKEY = '0c35a2274886c1f8571a1c419dd764fa';
  static final APIClient _instance = APIClient._internal();

  factory APIClient() => _instance;

  APIClient._internal();

  static Future<dynamic> get(
    String route, {
    Map<String, String>? headers,
  }) async {
    final Uri url = Uri.parse("$baseUrl$route");
    log(url.toString());

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }..addAll(headers ?? {}),
    );

    return _handleResponse(response);
  }

  static Future<dynamic> post(String route,
      {dynamic data, Map<String, String>? header, File? file}) async {
    final Uri url = Uri.parse(route);
    debugPrint(url.toString());
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }..addAll(header ?? {});
    if (file != null) {
      var request = http.MultipartRequest('POST', Uri.parse(route));
      request.fields.addAll(data as Map<String, String>);
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('image', file.path));

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedBody = {"dummy": "dummy"};
        return decodedBody;
      } else if (response.statusCode == 400) {
        final decodedBody = {"dummy": ""};
        return decodedBody;
      }
      throw Exception('Request failed with status: ${response.statusCode}');
    }
    final response = await http.post(
      url,
      headers: headers,
      body: data != null ? jsonEncode(data) : null,
    );

    debugPrint('${response.statusCode}');
    debugPrint(response.body);

    return _handleResponse(response);
  }

  /// Sends a DELETE request to the specified [route].
  static Future<dynamic> delete(
    String route, {
    Map<String, String>? headers,
  }) async {
    final Uri url = Uri.parse(route);

    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
        ..addAll(headers ?? {}),
    );

    return _handleResponse(response);
  }

  /// Sends a PUT request to the specified [route] with the given [data].
  static Future<dynamic> put(String route, dynamic data,
      {Map<String, String>? headers}) async {
    final Uri url = Uri.parse(route);

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
        ..addAll(headers ?? {}),
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  static Future<dynamic> _handleResponse(http.Response response) async {
    log('${response.statusCode}');
    log(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      } else {
        return {"dummy": "dummy"};
      }
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
