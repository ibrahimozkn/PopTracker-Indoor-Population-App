import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class DioClient{
  static final dio = Dio();
  static const String serviceUrl = "http://ec2-3-86-218-135.compute-1.amazonaws.com:8000/api/population/";

  static Future<Either<int, String>> fetchPopulation() async{

    dio.options.baseUrl = serviceUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    try{
      final response = await dio.get("/1");

        if (response.statusCode != 200) {
          return Right("HTTP ${response.statusCode} error");
        }

        print(response.data);

        print(response.data[0]["count"]);
        return Left(response.data[0]["count"]);
    }on DioError catch (e){
      return Right(e.message);
    }



  }

  static Future<Either<bool, String>> incrementPopulation() async{

    dio.options.baseUrl = serviceUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    try{
      final response = await dio.post("/add/1");

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
      final response = await dio.post("/remove/1");

      if (response.statusCode != 200) {
        return Right("HTTP ${response.statusCode} error");
      }

      return Left(true);
    }on DioError catch (e){
      return Right(e.message);
    }



  }
}