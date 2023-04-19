import 'dart:convert';

import 'package:dio/dio.dart';

//BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
var options = BaseOptions(
  //请求基地址,可以包含子路径
  baseUrl: "http://localhost:3060",
  //连接服务器超时时间，单位是毫秒.
  connectTimeout: 10000,
  //响应流上前后两次接受到数据的间隔，单位为毫秒。
  receiveTimeout: 5000,
  //Http请求头.
  headers: {
    //do something
    "version": "1.0.0"
  },
  //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
  responseType: ResponseType.json,
);

class HttpUtil {
  static final Dio dio = Dio(options);

  static Future<dynamic> get(String url,
      {Map<String, dynamic>? params, Options? options}) async {
    Response response =
        await dio.get(url, queryParameters: params, options: options);
    return jsonDecode(response.toString());
  }

  static Future<dynamic> post(String url,
      {Map<String, dynamic>? params, dynamic data, Options? options}) async {
    Response response = await dio.post(url,
        queryParameters: params, data: data, options: options);
    return jsonDecode(response.toString());
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.response) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response? response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response?.data;
  }
}
