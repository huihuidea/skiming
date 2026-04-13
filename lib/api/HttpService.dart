import 'dart:math';

import 'package:babay_pro/Utils/Storage.dart';
import 'package:dio/dio.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;

  late Dio _dio;
  HttpService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://babyserver-production.up.railway.app',
        connectTimeout: Duration(seconds: 5000),
        receiveTimeout: Duration(seconds: 5000),
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) {
          return status! < 500; // 允许 400-499 状态码
        },
      ),
    );

    //添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handle) {
          final token = Storage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = "Bearer $token";
          }
          print(
            "onRequest---: ${options.uri} ${options.method} ${options.headers} ${options.data}",
          );
          return handle.next(options);
        },
        onResponse: (options, handle) {
          print("onResponse---:${options.data}");
          return handle.next(options);
        },
        onError: (error, handle) {
          print("onError---:$error");
          return handle.next(error);
        },
      ),
    );
  }

  // GET 请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }

  // POST 请求
  Future<Response> post(String path, Map<String, dynamic> pamrams) async {
    try {
      final response = await _dio.post(path, data: pamrams);
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }

  // Patch 请求
  Future<Response> patch(String path, Map<String, dynamic> pamrams) async {
    try {
      final response = await _dio.patch(path, data: pamrams);
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
}
