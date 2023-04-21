import 'dart:convert';

import 'package:dio/dio.dart';

import '../config/Config.dart';
import 'ToastUtil.dart';

class DioManager {
  static final DioManager _instance = DioManager._internal();

  factory DioManager() {
    return _instance;
  }

  static Dio? _dio;

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      // It occurs when url is opened timeout.
      ToastUtil.show("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      ToastUtil.show("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      ToastUtil.show("响应超时");
    } else if (e.type == DioErrorType.response) {
      // When the server response, but with a incorrect status, such as 404, 503...
      ToastUtil.show("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      ToastUtil.show("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      ToastUtil.show("未知错误: ${e.message}");
    }
  }

  // 私有构造函数
  DioManager._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Config.apiBaseUrl,
      connectTimeout: 5000 * 60,
      receiveTimeout: 1000 * 60,
    );

    _dio = Dio(options);

    // 添加拦截器
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('请求之前');
        // 在这里可以处理请求相关的逻辑，例如添加 Token
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('响应之前');
        // 在这里可以处理响应相关的逻辑
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        formatError(e);
        // 在这里可以处理错误相关的逻辑
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio!;

  static Future request(
    String url,
    String method,
    Map<String, dynamic> params, {
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      Response response;
      Options requestOptions = Options(
        method: method,
        headers: headers,
        contentType: isFormData ? 'multipart/form-data' : 'application/json',
      );
      response =
          await _dio!.request(url, options: requestOptions, data: params);
      return jsonDecode(response.toString());
    } on DioError catch (e) {
      print('请求出错：$e');
    }
  }

  static Future<dynamic> get(String url,
      {Map<String, dynamic>? params, Options? options}) async {
    try {
      Response response =
          await _dio!.get(url, queryParameters: params, options: options);
      return jsonDecode(response.toString());
    } on DioError catch (e) {
      print('请求出错：$e');
    }
  }

  static Future<dynamic> post(String url,
      {Map<String, dynamic>? params, dynamic data, Options? options}) async {
    try {
      Response response = await _dio!
          .post(url, queryParameters: params, data: data, options: options);
      return jsonDecode(response.toString());
    } on DioError catch (e) {
      print('请求出错：$e');
    }
  }
}
