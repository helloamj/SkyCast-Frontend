import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:skycast/constants/api_constants.dart';
import 'package:skycast/helpers/fluttertoast_helper/fluttertoast_helper.dart';

class ApiHelper {
  static Future<dynamic> get(String url,
      {Map<String, dynamic> queryParams = const {}}) async {
    try {
      queryParams['appid'] = ApiConstants.apiKey;
      final response = await http.get(
        Uri.https(ApiConstants.baseURL, url, queryParams),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*"
        },
      );

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      _logAndThrowException('Network error: ${e.message}', 'ApiHelper.get',
          NetworkException(e.message));
    } catch (e) {
      _logAndThrowException(
          'Unknown error: $e', 'ApiHelper.get', ApiException(e.toString()));
    }
  }

  static Future<dynamic> post(String url, dynamic data) async {
    try {
      final response = await http.post(
        Uri.https(ApiConstants.baseURL, url),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*"
        },
        body: json.encode(data),
      );

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      _logAndThrowException('Network error: ${e.message}', 'ApiHelper.post',
          NetworkException(e.message));
    } catch (e) {
      _logAndThrowException(
          'Unknown error: $e', 'ApiHelper.post', ApiException(e.toString()));
    }
  }

  static Future<dynamic> put(String url, dynamic data) async {
    try {
      final response = await http.put(
        Uri.https(ApiConstants.baseURL, url),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*"
        },
        body: json.encode(data),
      );

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      _logAndThrowException('Network error: ${e.message}', 'ApiHelper.put',
          NetworkException(e.message));
    } catch (e) {
      _logAndThrowException(
          'Unknown error: $e', 'ApiHelper.put', ApiException(e.toString()));
    }
  }

  static Future<dynamic> delete(String url) async {
    try {
      final response = await http.delete(
        Uri.https(ApiConstants.baseURL, url),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*"
        },
      );

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      _logAndThrowException('Network error: ${e.message}', 'ApiHelper.delete',
          NetworkException(e.message));
    } catch (e) {
      _logAndThrowException(
          'Unknown error: $e', 'ApiHelper.delete', ApiException(e.toString()));
    }
  }

  static dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw BadRequestException('Bad request: ${response.body}');
      case 401:
        throw UnauthorizedException('Unauthorized: ${response.body}');
      case 404:
        throw NotFoundException('Not found: ${response.body}');
      case 500:
        throw InternalServerException(
            'Internal server error: ${response.body}');
      default:
        throw ApiException('Failed to load data: ${response.body}');
    }
  }

  static void _logAndThrowException(
      String message, String methodName, ApiException exception) {
    log(message, name: methodName);

    FluttertoastHelper.showToast(_getFriendlyMessage(exception));

    throw exception;
  }

  static String _getFriendlyMessage(ApiException exception) {
    if (exception is NetworkException) {
      return 'Network error. Please check your internet connection and try again.';
    } else if (exception is BadRequestException) {
      return 'Bad request. Please try again.';
    } else if (exception is UnauthorizedException) {
      return 'Unauthorized access. Please log in again.';
    } else if (exception is NotFoundException) {
      return 'Requested resource not found. Please try again.';
    } else if (exception is InternalServerException) {
      return 'Server error. Please try again later.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => 'ApiException: $message';
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class BadRequestException extends ApiException {
  BadRequestException(super.message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message);
}

class InternalServerException extends ApiException {
  InternalServerException(super.message);
}
