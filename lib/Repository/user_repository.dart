import 'dart:convert';

import 'package:dio/dio.dart';

class UserRepository {
  final Dio dio =
      Dio(BaseOptions(baseUrl: 'https://student.valuxapps.com/api/'));
  Future<Response> registerNewUser(
      String name, String phone, String email, String password) async {
    final response = await dio.post('register', data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "image": ""
    });
    return response;
  }
  Future<Response> LoginUser(String email, String password) async {
    final response = await dio.post('login', data: {

      "email": email,
      "password": password,
    });
    return response;
  }

}
