// abstract class service

import 'package:dio/dio.dart';

abstract class ApiService1<T> {
  // abstract method
  final dio = Dio();
  Future<T> getAll();
  T create(T t);
  T update(T t);
  T delete(T t);
}