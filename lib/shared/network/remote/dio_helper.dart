import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      // baseUrl: 'https://sms.gxadev.me/api/',
      baseUrl: 'https://sms.gxadev.me/api/',
      receiveDataWhenStatusError: true,
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },


    )

    );
  }

  static Future<Response?> getData({
    required String url,
     Map<String, dynamic>? query,
    String? token,
  })async {
    dio?.options.headers={
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    };
    return await dio?.get(url, queryParameters: query);
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? query,
   required Map<String, dynamic> data,
    String? token,
  })async {
    dio?.options.headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    } ;
    return await dio?.post(url, queryParameters: query,data: data);
  }

  static Future<Response?> postFile({
    required String url,
    Map<String, dynamic>? query,
    required FormData data,
    String? token,
  }) async {
    dio?.options.headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    };
    return await dio?.post(url, queryParameters: query, data: data);
  }

  static Future<Response?> postAssignmentFile({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
    File? file,
  }) async {
    dio?.options.headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    };

    if (file == null) {
      throw Exception('File is null');
    }

    if (!file.existsSync()) {
      throw Exception('File does not exist');
    }

    // data['files[]'] = await MultipartFile.fromFile(
    //   file.path,
    //   filename: file.path.split('/').last,
    // );
    MultipartFile multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );

    FormData formData = FormData.fromMap({
      'files': [multipartFile],
    });
    data[formData];




    return await dio?.post(url, queryParameters: query, data: data);
  }


  static Future<Response?> postFileWithDate({
    required String url,
    Map<String, dynamic>? query,
    required FormData data,
    String? token,
    required String fileFieldName,
    required String dateFieldName,
    required FormData file,
    required String date,
  }) async {
    dio?.options.headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    };

    data.fields.addAll([
      MapEntry(fileFieldName, MultipartFile.fromFileSync(file as String) as String),
      MapEntry(dateFieldName, date),
    ]);

    return await dio?.post(
      url,
      queryParameters: query,
      data: data,
    );
  }





  static Future<Response?> uploadFile({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
    String? fileFieldName,
    String? filePath,
  }) async {
    dio?.options.headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    };

    FormData formData = FormData();

    if (data != null) {
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    if (filePath != null && fileFieldName != null) {
      formData.files.add(MapEntry(
        fileFieldName,
        await MultipartFile.fromFile(filePath),
      ));
    }

    return await dio?.post(url, queryParameters: query, data: formData);
  }

  static Future<Response?> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer $token',
    };

    return await dio?.delete(url, queryParameters: query);
  }
}


