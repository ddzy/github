import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:github/main.dart';
import 'package:github/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart' show $constants;

d.Dio _createService() {
  var service = d.Dio(d.BaseOptions(
    baseUrl: $constants.githubConfig.baseApiUrl,
    headers: {
      'Content-Type': 'application/json',
      'X-GitHub-Api-Version': $constants.githubConfig.apiVersion
    },
  ));
  service.interceptors.add(d.InterceptorsWrapper(
    /// 请求拦截器
    onRequest: (options, handler) async {
      var storage = await SharedPreferences.getInstance();
      var token = storage.getString($constants.storageToken.githubAccessToken);
      var newOptions = options.copyWith(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      handler.next(newOptions);
    },

    /// 响应拦截器
    onResponse: (response, handler) {
      handler.resolve(response);
    },
    onError: (error, handler) {
      var response = error.response;
      var context = $router.currentContext!;

      // 鉴权失败，跳转到登录页
      if (response!.statusCode == 401) {
        $utils.showSnackBar(context,
            Text('${response.statusCode} - ${response.statusMessage}'));
        context.replace('/login');
      }
      handler.reject(error);
    },
  ));

  return service;
}

var $service = _createService();
