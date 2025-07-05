import 'package:app_factory/core/api/end_points.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  static Dio? dio;

  static void init() {
    const Duration timeout = Duration(seconds: 10);
    dio = Dio();
    dio
      ?..options.baseUrl = EndPoints.baseUrl
      ..options.connectTimeout = timeout
      ..options.receiveTimeout = timeout
      ..options.receiveDataWhenStatusError = true;
    addHeader();
  }

  static void addHeader() {
    dio?.options.headers = {'Content-Type': 'application/json'};
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    return await dio!.post(url, queryParameters: query, data: data);
  }
}
