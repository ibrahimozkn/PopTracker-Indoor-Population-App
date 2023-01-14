import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:poptrack/data/models/business.dart';
import 'package:poptrack/data/models/dioclient.dart';
import 'package:poptrack/data/models/population_data.dart';

import '../models/failure.dart';

class BusinessRepository extends DioClient{
  Future<Either<Failure, bool>> addBusiness(Business business, String token) async{

    Response response;

    Map<String, String> bearer = {
      "Authorization": "Bearer $token",
    };
    this.option.headers!.addAll(bearer);

    try{
      response = await client.post("/api/business",
          data: {
            'name': business.name,
            'address': business.address,
            'coordinates': business.coord,
          },
          options: this.option);
      print(response.data);
    }on DioError catch(e){
      return Left(Failure(error: e.message));
    }


    if (response.statusCode != 200) {
      return Left(Failure(error: response.data['message']));
    } else {
      return Right(true);
    }
  }

  Future<Either<Failure, bool>> editBusiness(Business business, String token) async{

    Response response;

    Map<String, String> bearer = {
      "Authorization": "Bearer $token",
    };
    this.option.headers!.addAll(bearer);

    try{
      response = await client.post("/api/editBusiness",
          data: {
            'name': business.name,
            'address': business.address,
            'id': business.id,
          },
          options: this.option);
      print(response.data);
    }on DioError catch(e){
      return Left(Failure(error: e.message));
    }


    if (response.statusCode != 200) {
      return Left(Failure(error: response.data['message']));
    } else {
      return Right(true);
    }
  }

  Future<Either<Failure, bool>> deleteBusiness(int id, String token) async{

    Response response;

    Map<String, String> bearer = {
      "Authorization": "Bearer $token",
    };
    this.option.headers!.addAll(bearer);

    try{
      response = await client.post("/api/deleteBusiness/$id",
          options: this.option);
      print(response.data);
    }on DioError catch(e){
      return Left(Failure(error: e.message));
    }


    if (response.statusCode != 200) {
      return Left(Failure(error: response.data['message']));
    } else {
      return Right(true);
    }
  }

  Future<Either<Failure, List<Business>>> getBusinesses(String token) async{
    Map<String, String> bearer = {
      "Authorization": "Bearer $token",
    };
    this.option.headers!.addAll(bearer);

    Response response;
    try {
      response = await client.get("/api/business", options: this.option);
      print(response.data);
    } on DioError catch (e) {
      return Left(Failure(error: e.message));
    }

    if (response.statusCode != 200) {
      return Left(Failure(error: "HTTP status error: " + response.statusCode.toString()));
    }

    return Right(response.data.map<Business>((json) => Business.fromJson(json)).toList());


  }

  Future<Either<Failure, List<PopulationData>>> getPopulationHistory(int id, String token) async{
    Map<String, String> bearer = {
      "Authorization": "Bearer $token",
    };
    this.option.headers!.addAll(bearer);
    Response response;
    try {
      response = await client.get("/api/history/$id", options: this.option);
      print(response.data);
    } on DioError catch (e) {
      return Left(Failure(error: e.message));
    }

    if (response.statusCode != 200) {
      return Left(Failure(error: "HTTP status error: " + response.statusCode.toString()));
    }

    return Right(response.data.map<PopulationData>((json) => PopulationData.fromJson(json)).toList());


  }

  Future<Either<Failure, int>> getPopulation(int id) async{

    Response response;
    try {
      response = await client.get("api/population/$id", options: this.option);
      print(response.data);
    } on DioError catch (e) {
      return Left(Failure(error: e.message));
    }

    if (response.statusCode != 200) {
      return Left(Failure(error: "HTTP status error: " + response.statusCode.toString()));
    }

    return Right(response.data[0]['count'] as int);


  }

}