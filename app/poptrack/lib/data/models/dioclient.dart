import 'package:dio/dio.dart';

abstract class DioClient{
  Dio client = Dio();
  String url = "http://46.20.6.9:8000";
  Options option = Options(
    validateStatus: (_) => true,
    contentType: Headers.jsonContentType,
    headers: {
      "Accept" : 'application/json'
    },
    responseType: ResponseType.json,
  );

  DioClient(){
    client.options.connectTimeout = 12000;
    client.options.receiveTimeout = 12000;
    client.options.followRedirects = false;
    client.options.baseUrl = url;
    client.options.contentType = Headers.jsonContentType;
  }

}