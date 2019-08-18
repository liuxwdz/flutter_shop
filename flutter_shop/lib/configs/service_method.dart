import 'package:dio/dio.dart';
import 'dart:io';
import 'services_urls.dart';

Future getHomePageContent() async {
  print('开始获取首页数据');
  Response response;
  try {
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    var data = {'lon': '114.06667', 'lat': '22.61667'};
    response = await dio.post(servicePath['homePageContent'], data: data);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('homePageContent接口异常');
    }
  } catch (e) {
    return print(e);
  }
}
