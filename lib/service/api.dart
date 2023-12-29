import 'package:dio/dio.dart';
import './service.dart' show $service;

class _Api {
  /// https://docs.github.com/zh/rest/users/users?apiVersion=2022-11-28#get-the-authenticated-user
  Future<Response> getUser() {
    return $service.get('/user');
  }
}

var $api = _Api();