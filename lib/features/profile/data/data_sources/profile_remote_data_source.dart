import 'package:dio/dio.dart';
import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/profile/data/models/profile_model.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<void> updateProfile({String? name, String? phone, String? avatarFilePath});
  Future<void> changePassword(Map<String, dynamic> data);
  Future<List<TicketModel>> getTickets();
  Future<TicketModel> getTicketDetails(int ticketId);
  Future<TicketReplyModel> replyToTicket(int ticketId, String message);
  Future<TicketModel> closeTicket(int ticketId);
  Future<void> createTicket(Map<String, dynamic> ticketData);
  Future<List<SubscriptionPlan>> getSubscriptionPlans();
  Future<List<ActiveSubscription>> getMySubscriptions();
  Future<void> deleteAccount();
  Future<void> logout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  // ignore: unused_field
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _apiClient.get(ApiConstants.profile);
    return ProfileModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> updateProfile({String? name, String? phone, String? avatarFilePath}) async {
    final Map<String, dynamic> mapStream = {};
    if (name != null) mapStream['name'] = name;
    if (phone != null) mapStream['phone'] = phone;
    
    if (avatarFilePath != null) {
      mapStream['avatar'] = await MultipartFile.fromFile(avatarFilePath);
    }

    final formData = FormData.fromMap(mapStream);
    await _apiClient.post(ApiConstants.updateProfile, data: formData);
  }

  @override
  Future<void> changePassword(Map<String, dynamic> data) async {
    await _apiClient.post(ApiConstants.changePassword, data: data);
  }

  @override
  Future<List<TicketModel>> getTickets() async {
    final response = await _apiClient.get(ApiConstants.tickets);
    final List<dynamic> data = response.data['data']['data'];
    return data.map((json) => TicketModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<TicketModel> getTicketDetails(int ticketId) async {
    final response = await _apiClient.get(ApiConstants.ticketDetails(ticketId));
    final Map<String, dynamic> data = response.data['data'] as Map<String, dynamic>;
    return TicketModel.fromJson(data);
  }

  @override
  Future<TicketReplyModel> replyToTicket(int ticketId, String message) async {
    final response = await _apiClient.post(
      ApiConstants.ticketReply(ticketId),
      data: {'message': message},
    );

    final Map<String, dynamic> responseData =
        response.data as Map<String, dynamic>;
    final bool success = responseData['success'] as bool? ?? true;

    if (!success) {
      throw ServerException(
        message:
            responseData['message'] as String? ??
            'Failed to send reply',
      );
    }

    final Map<String, dynamic> data = responseData['data'] as Map<String, dynamic>;
    return TicketReplyModel.fromJson(data);
  }

  @override
  Future<TicketModel> closeTicket(int ticketId) async {
    final response = await _apiClient.post(ApiConstants.closeTicket(ticketId));

    final Map<String, dynamic> responseData =
        response.data as Map<String, dynamic>;
    final bool success = responseData['success'] as bool? ?? true;

    if (!success) {
      throw ServerException(
        message:
            responseData['message'] as String? ??
            'Failed to close ticket',
      );
    }

    final Map<String, dynamic> data = responseData['data'] as Map<String, dynamic>;
    return TicketModel.fromJson(data);
  }

  @override
  Future<void> createTicket(Map<String, dynamic> ticketData) async {
    await _apiClient.post(ApiConstants.tickets, data: ticketData);
  }

  @override
  Future<List<SubscriptionPlan>> getSubscriptionPlans() async {
    final response = await _apiClient.get(ApiConstants.subscriptionPlans);
    final List<dynamic> data = response.data['data'];
    return data.map((json) => SubscriptionPlan.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<ActiveSubscription>> getMySubscriptions() async {
    final response = await _apiClient.get(ApiConstants.mySubscriptions);
    final List<dynamic> data = response.data['data'];
    return data.map((json) => ActiveSubscription.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> deleteAccount() async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.delete('/profile');
  }

  @override
  Future<void> logout() async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.post('/auth/logout');
  }
}
