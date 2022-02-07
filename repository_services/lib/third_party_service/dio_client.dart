import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:repository_services/setup_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio dio;

  DioClient._(this.dio);

  static DioClient? _instance;

  factory DioClient.instance() {
    final dioClient = _instance;
    if (dioClient == null) {
      final dio = Dio();
      final dioClient = DioClient._(dio);
      _instance = dioClient;
      return dioClient;
    } else {
      return dioClient;
    }
  }

  void optionSetup(SetupService setupService) {
    dio.options.baseUrl = setupService.baseUrl;
    dio.options.connectTimeout = setupService.connectTimeOut;
    dio.options.connectTimeout = setupService.receiveTimeOut;
    dio.options.headers = setupService.headers;

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }
  }

  void setupDioWithOption(BaseOptions options) {
    dio.options = options;
  }
}
