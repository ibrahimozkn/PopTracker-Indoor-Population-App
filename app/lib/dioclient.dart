import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class DioClient{
  static final dio = Dio();
  static const String serviceUrl = "http://172.17.112.1";

  static Future<Either<int, String>> fetchPopulation() async{

    dio.options.baseUrl = serviceUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    try{
      final response = await dio.get("/AppService.php", queryParameters: {
        'Operation': 'GetPickingProducts',
      });

        if (response.statusCode != 200) {
          return Right("HTTP ${response.statusCode} error");
        }

        return Left(1);
    }on DioError catch (e){
      return Right(e.message);
    }



  }

  static Future<Either<bool, String>> incrementPopulation() async{

    dio.options.baseUrl = serviceUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    try{
      final response = await dio.post("/AppService.php", queryParameters: {
        'Operation': 'GetPickingProducts',
      });

      if (response.statusCode != 200) {
        return Right("HTTP ${response.statusCode} error");
      }

      return Left(true);
    }on DioError catch (e){
      return Right(e.message);
    }



  }

  static Future<Either<bool, String>> decrementPopulation() async{

    dio.options.baseUrl = serviceUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    try{
      final response = await dio.post("/AppService.php", queryParameters: {
        'Operation': 'GetPickingProducts',
      });

      if (response.statusCode != 200) {
        return Right("HTTP ${response.statusCode} error");
      }

      return Left(true);
    }on DioError catch (e){
      return Right(e.message);
    }



  }
}