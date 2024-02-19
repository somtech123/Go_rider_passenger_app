// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_rider/app/api/endpoint.dart';
import 'package:go_rider/app/resouces/app_logger.dart';

var log = getLogger('api');

class Api {
  final Dio _dio;
  Api(this._dio) {
    initializeDio();
  }
  set setDioHeaders(Map<String, dynamic> data) => _dio.options.headers = data;

  /// This allows you set [header] options outside the api class
  void setExtraHeaders(Map<String, dynamic> newHeaders) {
    Map<String, dynamic> existingHeaders = _dio.options.headers;
    newHeaders.forEach((key, value) =>
        existingHeaders.update(key, (_) => value, ifAbsent: () => value));
    _dio.options.headers = existingHeaders;
  }

  void initializeDio() {
    _dio.options = BaseOptions(
        connectTimeout: const Duration(minutes: 8),
        receiveTimeout: const Duration(minutes: 8),
        baseUrl: Endpoint.baseUrl,
        contentType: "application/json",
        headers: {
          "accept": "application/json",
        });

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: requestInterceptors,
      onError: onErrorInterceptorHandler,
      onResponse: responseInterceptors,
    ));

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  requestInterceptors(RequestOptions requestOptions,
      RequestInterceptorHandler requestInterceptorHandler) async {
    //await setToken(requestOptions);

    requestOptions.uri.path.replaceAll("+", " ");

    requestOptions.headers.addAll({
      "accept": "application/json",
      "content-type": "application/json",
      "Authorization": "Bearer ${dotenv.env['PUSH_NOTIFICATION_BEARER']}"
    });

    log.w('REQUEST URI ==============> ${requestOptions.uri}');
    log.w('REQUEST METHODS ==============> ${requestOptions.method}');
    log.w('REQUEST HEADERS ==============> ${requestOptions.headers}');
    log.w('REQUEST DATA ==============> ${requestOptions.data}');
    return requestInterceptorHandler.next(requestOptions);
  }

  // Future setToken(RequestOptions option) async {
  //   option.headers = {
  //     "Authorization": "Bearer sk_test_tvfjjVHLoh91p5eqPJzzej32LtNWPgMvTykSf7E6"
  //   };
  // }

  errorInterceptors(
      DioError dioError, ErrorInterceptorHandler errorInterceptorHandler) {
    return errorInterceptorHandler.next(dioError);
  }

  responseInterceptors(Response<dynamic> response,
      ResponseInterceptorHandler responseInterceptorHandler) {
    "======================================================================>";

    log.w("RESPONSE DATA ==============>  ${response.data}");
    log.w("RESPONSE HEADERS ==============>  ${response.headers}");
    log.w("RESPONSE STATUSCODE ==============>  ${response.statusCode}");
    log.w("RESPONSE STATUSMESSAGE ==============>  ${response.statusMessage}");
    "======================================================================>";
    return responseInterceptorHandler.next(response);
  }

  apiResponse({dynamic message, dynamic errorCode}) {
    return {
      "message": message ?? "an_error_occurred_please_try_again",
      "errorCode": errorCode ?? "000",
    };
  }

  onErrorInterceptorHandler(DioError e, handler) async {
    return handler.next(e); //continue
  }

  Dio get dio => _dio;

  Response? handleError(DioError? e) {
    // log.w();
    log.w(
        "=============================[ALERT-😱😱😱]: ${e?.requestOptions.uri} ");
    log.w("=====================================: [ALERT-😱😱😱] ${e?.error} ");
    log.w(
        "=====================================: [ALERT-😱😱😱] ${e?.response?.statusCode}");
    log.w(
        "=====================================: [ALERT-😱😱😱] ${e?.response?.data}");

    Response? response;

    switch (e?.type) {
      case DioErrorType.cancel:
        response = Response(
          data: apiResponse(
            message: 'Request cancelled!',
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.connectionTimeout:
        response = Response(
          data: apiResponse(
            message: "Network connection timed out!",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.receiveTimeout:
        response = Response(
          data: apiResponse(
            message: "Something went wrong. Please try again later!",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.sendTimeout:
        response = Response(
          data: apiResponse(
            message: "Something went wrong. Please try again later",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;

      case DioErrorType.unknown:
        if (e?.error is SocketException) {
          response = Response(
            data: apiResponse(
              message: "An error occurred, please try again",
              errorCode: '404',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e?.error is HttpException) {
          response = Response(
            data: apiResponse(
              message: "Network connection issue",
            ),
            requestOptions: RequestOptions(path: ''),
          );
        }
        break;
      default:
        if (e!.response!.data.runtimeType == String &&
            e.error.toString().contains("404")) {
          response = Response(
            data: apiResponse(
              message: "An error occurred, please try again",
              errorCode: '404',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e.response?.data.runtimeType == String &&
            e.error.toString().contains("400")) {
          response = Response(
            data: apiResponse(
              message:
                  e.response?.data ?? "An error occurred, please try again",
              errorCode: '400',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e.response?.data.runtimeType == String &&
            e.error.toString().contains("422")) {
          response = Response(
            data: apiResponse(
              message:
                  e.response?.data ?? "An error occurred, please try again",
              errorCode: '422',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e.response!.statusCode == 401) {
          response = Response(
            data: apiResponse(
              message:
                  e.response?.data ?? "An error occurred, please try again",
              errorCode: '401',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e.response!.statusCode == 500) {
          response = Response(
              requestOptions: RequestOptions(path: ''),
              data: apiResponse(
                  message: e.response?.data ?? 'Internal Server Error',
                  errorCode: '500'));
        } else {
          response = Response(
              data: apiResponse(
                  message: e.response!.data ?? "null",
                  errorCode: e.response!.data["errorCode"] ?? "null"),
              statusCode: e.response?.statusCode ?? 000,
              requestOptions: RequestOptions(path: ''));
        }
    }
    return response;
  }

  // Returns the same instance of dio throughout the application
  Api clone() => Api(_dio);
}
