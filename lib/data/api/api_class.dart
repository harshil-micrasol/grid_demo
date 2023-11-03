import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../res/color_print.dart';
import '../../utils/ui_utils.dart';
import '../handler/api_url.dart';

class HttpUtil {
  final bool showErrorToast = true;

  factory HttpUtil() => _instance();

  static HttpUtil _instance() => HttpUtil._internal();

  late Dio dio;
  CancelToken cancelToken = CancelToken();
  String apiUrl = ApiUrls.baseUrl;
  BuildContext? context;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl,
      connectTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 7),
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
        error: true,
        compact: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          try {
            if (e.response != null) {
              UiUtils.toast(e.response?.data['message'].toString());
            }
            if (e.response!.data['api_slug'].toString() == "login") {
              apiErrorHandler(e.response != null ? e.response!.statusCode! : 00, isLogin: true);
            } else {
              apiErrorHandler(e.response != null ? e.response!.statusCode! : 00, isLogin: false);
            }
            onError(createErrorEntity(e));
          } catch (err) {
            printErrors(errText: "$e", type: "CreateErrorEntity function");
          }
          return handler.next(e); //continue
        },
      ),
    );
  }

  Future apiErrorHandler(int statusCode, {bool isLogin = false}) async {
    try {
      if (statusCode == 400) {
      } else if (statusCode == 401) {
      } else if (statusCode == 403) {}
    } catch (e, stackTrace) {
      printWarning(stackTrace.toString());
    }
  }

  Future socketErrorHandler(int? statusCode) async {
    try {
      if (statusCode == 403) {}
    } catch (e, stackTrace) {
      printWarning(stackTrace.toString());
    }
  }

  // On Error....
  void onError(ErrorEntity eInfo) {
    printWarning("error.code -> ${eInfo.code}, error.message -> ${eInfo.message}");
    if (eInfo.message.isNotEmpty) {
      if (showErrorToast == true) {
        // toast(eInfo.message);
      }
    }
  }

  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "Request to server was cancelled");
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -2, message: "Connection timeout with server");
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -3, message: "Send timeout in connection with server");
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -4, message: "Receive timeout in connection with server");
      case DioExceptionType.badResponse:
        {
          try {
            int errCode = error.response != null ? error.response!.statusCode! : 00;
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "Request syntax error");
              case 401:
                return ErrorEntity(code: errCode, message: "Permission denied");
              case 403:
                return ErrorEntity(code: errCode, message: "Server refuses to execute");
              case 404:
                return ErrorEntity(code: errCode, message: "Can not reach server");
              case 405:
                return ErrorEntity(code: errCode, message: "Request method is forbidden");
              case 500:
                return ErrorEntity(code: errCode, message: "Internal server error");
              case 502:
                return ErrorEntity(code: errCode, message: "Invalid request");
              case 503:
                return ErrorEntity(code: errCode, message: "Server hangs");
              case 505:
                return ErrorEntity(code: errCode, message: "HTTP protocol requests are not supported");
              default:
                return ErrorEntity(code: errCode, message: error.response != null ? error.response!.data! : "");
            }
          } on Exception catch (_) {
            return ErrorEntity(code: 00, message: "Unknown mistake");
          }
        }
      case DioExceptionType.unknown:
        if (error.message != null) {
          if (error.message!.contains("SocketException")) {
            return ErrorEntity(code: -5, message: "Your internet is not available, please try again later");
          } else {
            if (error.message!.contains("Software caused connection abort")) {
              return ErrorEntity(code: -6, message: "Your internet is not available, please try again later");
            }
          }
        }
        return ErrorEntity(code: -7, message: "Oops something went wrong");
      default:
        return ErrorEntity(code: -8, message: "Oops something went wrong");
    }
  }

  void cancelRequests() {
    cancelToken.cancel("cancelled");
  }

  /// restful get
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = true,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra!.addAll({
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post
  Future post(
    String path, {
    dynamic data,
    bool? isDecode = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.post(
      path,
      data: isDecode == false ? data : FormData.fromMap(data),
      // data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );

    return response.data;
  }

  /// restful put
  Future put(
    String path, {
    dynamic data,
    bool? isDecode = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.put(
      path,
      data: isDecode == false ? data : FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful delete
  Future delete(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful patch
  Future patch(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post Stream
  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  VoidCallback? callBack;

  ErrorEntity({
    required this.code,
    required this.message,
    this.callBack,
  });

  @override
  String toString() {
    callBack != null ? callBack!() : null;
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
