import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

// define what dio do

  static init() {
    dio = Dio(
      BaseOptions(

        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
          connectTimeout: 5000,
          receiveTimeout: 5000,
      ),
    );
  }



// method to getdata

 static Future<Response> getData(
      {@required String url, @required dynamic query}) async {
    return await dio.get(/*path*/ url,
        queryParameters: query);
  }

}
