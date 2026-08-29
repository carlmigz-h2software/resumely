import 'package:resumely/core/network/api_endpoints.dart';
import 'package:resumely/core/network/dio_client.dart';
import 'package:resumely/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dioClient.post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return UserModel.fromJson(data['user'] ?? data);
    }
    throw Exception('Invalid response format');
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await dioClient.post(
      ApiEndpoints.register,
      data: {
        'email': email,
        'password': password,
        'name': name,
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return UserModel.fromJson(data['user'] ?? data);
    }
    throw Exception('Invalid response format');
  }
}
