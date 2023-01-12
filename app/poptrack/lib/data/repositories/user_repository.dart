import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:poptrack/data/models/dioclient.dart';
import 'package:poptrack/data/models/user.dart';
import '../models/failure.dart';

class UserRepository extends DioClient {
  Future<Either<Failure, User>> login(String email, String password) async {
    Response response;

    try{
      response = await client.post("/api/login",
          data: {
            'email': email,
            'password': password,
          },
          options: this.option);
      print(response.data);

    }on DioError catch(e){
      return Left(Failure(error: e.message));
    }



    if (response.statusCode != 200 && response.data['message'] != null) {
      return Left(Failure(error: response.data['message']));
    } else {
      print("hey");
      return Right(User(token: response.data["token"]));
    }
  }

  Future<Either<Failure, bool>> logout(String token) async {
    Response response;

    this.option.headers = {
      "Authorization": "Bearer $token",
    };

    try{
      response = await client.post("/api/logout",
          options: this.option);
      print(response.data);
      print(response.realUri);
    }on DioError catch(e){
      return Left(Failure(error: e.message));
    }


    if (response.statusCode != 200) {
      return Left(Failure(error: "HTTP error:" + response.statusCode.toString() + " " + response.data));
    } else {
      return Right(true);
    }
  }

  Future<Either<Failure, bool>> register(User user) async {
    Response response;
    try{
      response = await client.post("/api/register",
          data: {
            'name': user.name,
            'email': user.email,
            'password': user.password,
            'password_confirmation': user.password,
          },
          options: this.option);
    }on DioError catch(e){
      return Left(Failure(error: e.message));
    }


    if (response.statusCode != 201) {
      return Left(Failure(error: response.data['message']));
    } else {
      return Right(true);
    }
  }
}
