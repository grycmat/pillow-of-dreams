import 'package:bedtime/services/http.service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  Dio get dio => Dio();
}