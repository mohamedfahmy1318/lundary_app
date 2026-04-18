import 'package:dio/dio.dart';
import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/profile/data/models/profile_model.dart';
import 'package:laundry/features/profile/data/models/subscription_checkout_model.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<void> updateProfile({
    String? name,
    String? phone,
    String? avatarFilePath,
    List<String>? addresses,
  });
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<List<TicketModel>> getTickets();
  Future<TicketModel> getTicketDetails(int ticketId);
  Future<TicketReplyModel> replyToTicket(int ticketId, String message);
  Future<TicketModel> closeTicket(int ticketId);
  Future<void> createTicket({
    required String subject,
    required String message,
    required String priority,
    required String category,
  });
  Future<List<TicketLookupOptionModel>> getTicketCategories();
  Future<List<TicketLookupOptionModel>> getTicketPriorities();
  Future<List<TicketLookupOptionModel>> getTicketStatuses();
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans();
  Future<List<ActiveSubscriptionModel>> getMySubscriptions();
  Future<SubscriptionCheckoutModel> subscribeToPlan(int planId);
  Future<void> deleteAccount();
  Future<void> logout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _apiClient.get(ApiConstants.profile);
    return ProfileModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> updateProfile({
    String? name,
    String? phone,
    String? avatarFilePath,
    List<String>? addresses,
  }) async {
    final formData = FormData();
    if (name != null) {
      formData.fields.add(MapEntry('name', name));
    }
    if (phone != null) {
      formData.fields.add(MapEntry('phone', phone));
    }
    if (addresses != null) {
      for (final address in addresses) {
        formData.fields.add(MapEntry('addresses[]', address));
      }
    }

    if (avatarFilePath != null) {
      formData.files.add(
        MapEntry('avatar', await MultipartFile.fromFile(avatarFilePath)),
      );
    }

    await _apiClient.post(
      ApiConstants.updateProfile,
      data: formData,
      options: Options(contentType: Headers.multipartFormDataContentType),
    );
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _apiClient.post(
      ApiConstants.changePassword,
      data: {
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      },
    );
  }

  @override
  Future<List<TicketModel>> getTickets() async {
    final response = await _apiClient.get(ApiConstants.tickets);
    final List<dynamic> data = response.data['data']['data'];
    return data
        .map((json) => TicketModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TicketModel> getTicketDetails(int ticketId) async {
    final response = await _apiClient.get(ApiConstants.ticketDetails(ticketId));
    final Map<String, dynamic> data =
        response.data['data'] as Map<String, dynamic>;
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
        message: responseData['message'] as String? ?? 'Failed to send reply',
      );
    }

    final Map<String, dynamic> data =
        responseData['data'] as Map<String, dynamic>;
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
        message: responseData['message'] as String? ?? 'Failed to close ticket',
      );
    }

    final Map<String, dynamic> data =
        responseData['data'] as Map<String, dynamic>;
    return TicketModel.fromJson(data);
  }

  @override
  Future<void> createTicket({
    required String subject,
    required String message,
    required String priority,
    required String category,
  }) async {
    await _apiClient.post(
      ApiConstants.tickets,
      data: {
        'subject': subject,
        'message': message,
        'priority': priority,
        'category': category,
      },
    );
  }

  @override
  Future<List<TicketLookupOptionModel>> getTicketCategories() async {
    final response = await _apiClient.get(ApiConstants.supportCategories);
    final List<dynamic> data = response.data['data'] as List<dynamic>;
    return data
        .map(
          (json) =>
              TicketLookupOptionModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<List<TicketLookupOptionModel>> getTicketPriorities() async {
    final response = await _apiClient.get(ApiConstants.supportPriorities);
    final List<dynamic> data = response.data['data'] as List<dynamic>;
    return data
        .map(
          (json) =>
              TicketLookupOptionModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<List<TicketLookupOptionModel>> getTicketStatuses() async {
    final response = await _apiClient.get(ApiConstants.supportStatuses);
    final List<dynamic> data = response.data['data'] as List<dynamic>;
    return data
        .map(
          (json) =>
              TicketLookupOptionModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans() async {
    final response = await _apiClient.get(ApiConstants.subscriptionPlans);
    final List<dynamic> data = response.data['data'];
    return data
        .map(
          (json) =>
              SubscriptionPlanModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<List<ActiveSubscriptionModel>> getMySubscriptions() async {
    final response = await _apiClient.get(ApiConstants.mySubscriptions);
    final List<dynamic> data = response.data['data'];
    return data
        .map(
          (json) =>
              ActiveSubscriptionModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<SubscriptionCheckoutModel> subscribeToPlan(int planId) async {
    final response = await _apiClient.post(
      ApiConstants.subscribeToPlan,
      data: {'plan_id': planId},
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return SubscriptionCheckoutModel.fromJson(data, planId: planId);
    }
    if (data is Map) {
      return SubscriptionCheckoutModel.fromJson(
        Map<String, dynamic>.from(data),
        planId: planId,
      );
    }

    throw const ServerException(message: 'Invalid subscription response.');
  }

  @override
  Future<void> deleteAccount() async {
    await _apiClient.delete(ApiConstants.profile);
  }

  @override
  Future<void> logout() async {
    await _apiClient.post(ApiConstants.logout);
  }
}
