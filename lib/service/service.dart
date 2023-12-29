import 'package:dio/dio.dart' as d;
import '../constants/constants.dart' as constants;

d.Dio createService() {
  var service = d.Dio(d.BaseOptions(
    baseUrl: constants.githubConfig.baseApiUrl,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer token',
      'X-GitHub-Api-Version': constants.githubConfig.apiVersion
    },
  ));
  service.interceptors.add(d.InterceptorsWrapper(
    onRequest: (options, handler) {},
    onResponse: (response, handler) {},
    onError: (error, handler) {},
  ));

  return service;
}

var service = createService();