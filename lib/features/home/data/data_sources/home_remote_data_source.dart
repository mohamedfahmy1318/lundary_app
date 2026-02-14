import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/home/data/models/post_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostById(int id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient _apiClient;

  HomeRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await _apiClient.get(ApiConstants.posts);
    final List<dynamic> data = response.data;
    return data.map((json) => PostModel.fromJson(json)).toList();
  }

  @override
  Future<PostModel> getPostById(int id) async {
    final response = await _apiClient.get('${ApiConstants.posts}/$id');
    return PostModel.fromJson(response.data);
  }
}
