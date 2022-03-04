import 'package:dio/dio.dart';
import 'package:post_delete_request/models/user_model.dart';

final dio = Dio(BaseOptions(baseUrl: baseURL));

const baseURL = "https://reqres.in/api/";

class UserService {
  Future<UserModel> postUser(String name, String job) async {
    final request = {"name": name, "job": job};

    try {
      Response response = await dio.post(
        "users",
        data: request,
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserModel> putUser(String name, String job) async {
    final request = {"name": name, "job": job};
    try {
      Response response = await dio.put("users/2", data: request);

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> deleteUser(String name, String job) async {
    final request = {"name": name, "job": job};

    try {
      Response response = await dio.delete("users/2", data: request);

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
