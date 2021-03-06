import 'package:dio/dio.dart';
import 'dart:io';
import '../configs/services_urls.dart';

Future getHomePageContent() async {
  print('开始获取首页数据');
  Response response;
  try {
    Dio dio = Dio();
    dio.options.contentType ='application/x-www-form-urlencoded';
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

Future postRequest(String urlKey, {formData}) async {
  print('开始获取数据');
  Response response;
  try {
    Dio dio = Dio();
    dio.options.contentType ='application/x-www-form-urlencoded';
    if (formData == null) {
      response = await dio.post(
        servicePath[urlKey],
      );
    } else {
      response = await dio.post(servicePath[urlKey], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(urlKey + '接口异常');
    }
  } catch (e) {
    return print(e);
  }
}
