import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (request, handler) async {
      var token = await GetStorage().read('login_token');
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      };
      request.headers.addAll(headers);
      print('${request.method} ${request.path}');
      print('${request.headers}');
      return handler.next(request);
    }, onResponse: (response, handler) {
      print('${response.data}');
      if (response.data['error'] == 1) throw response.data['message'];
      return handler.next(response);
    }, onError: (error, handler) {
      if (GET.Get.isDialogOpen == true) {
        GET.Get.back();
      }
      GET.Get.snackbar('error'.tr, '${error.message}',
          snackPosition: GET.SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);

      return handler.next(error);
    }));
  }

  static Future<Response> getGenres() async {
    return dio.get('/api/genres');
  }

  static Future<Response> getMovies(
      {int page = 1, String? type, int? genreId, int? actorId}) async {
    return dio.get('/api/movies', queryParameters: {
      'type': type,
      'genre_id': genreId,
      'page': page,
      'actor_id': actorId
    });
  }

  static Future<Response> getActors({required int movieId}) async {
    return dio.get(
      '/api/movies/${movieId}/actors',
    );
  }

  static Future<Response> getRelatedMovies({required int movieId}) async {
    return dio.get(
      '/api/movies/${movieId}/related_movies',
    );
  }

  static Future<Response> Login(
      {required Map<String, dynamic> loginData}) async {
    FormData formData = FormData.fromMap(loginData);
    return dio.post('/api/login', data: formData);
  }
  static Future<Response> register(
      {required Map<String, dynamic> registerData}) async {
    FormData formData = FormData.fromMap(registerData);
    return dio.post('/api/register', data: formData);
  }
  static Future<Response> getUsers() async {
    return dio.get(
      '/api/user',
    );
  }
  // ignore: non_constant_identifier_names
  static Future<Response> IsFavorit({required int movieId}) async {
    return dio.get(
      '/api/movies/${movieId}/is_favored',
    );
  }

}
