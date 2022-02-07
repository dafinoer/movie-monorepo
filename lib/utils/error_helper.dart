import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ErrorHelper {

  static String extractApiError(DioError error) {
    String message = "Something went wrong";
    debugPrint(
      'error === ${error.response}  ==== ${error.response != null ? error.response?.data : 'noresponse'} ==== ${error.response != null ? error.response?.extra : 'no response'}=== ${error.message}',
    );
    final isSocketException = error.error is SocketException;
    if (isSocketException || error.type == DioErrorType.connectTimeout) {
      message =
          "Cannot connect to server. Make sure you have proper internet connection";
    } else if (error.response != null &&
        error.response?.data['message'] != null) {
      message = error.response?.data['message'];
    } else {
      message = error.message;
    }
    return message;
  }
}
