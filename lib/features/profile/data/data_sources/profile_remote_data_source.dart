import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Map<String, dynamic>> getProfile();
  Future<void> updateProfile(Map<String, dynamic> data);
  Future<List<TicketModel>> getTickets();
  Future<void> createTicket(Map<String, dynamic> ticketData);
  Future<List<Map<String, dynamic>>> getSubscriptionPlans();
  Future<void> deleteAccount();
  Future<void> logout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  // ignore: unused_field
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Map<String, dynamic>> getProfile() async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.get('/profile');
    // return response.data['data'] as Map<String, dynamic>;
    return {
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'phone': '+966 123 456 789',
      'avatar': null,
    };
  }

  @override
  Future<void> updateProfile(Map<String, dynamic> data) async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.put('/profile', data: data);
  }

  @override
  Future<List<TicketModel>> getTickets() async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.get('/support/tickets');
    // final List<dynamic> data = response.data['data'];
    // return data.map((j) => TicketModel.fromJson(j)).toList();
    return TicketModel.mockTickets;
  }

  @override
  Future<void> createTicket(Map<String, dynamic> ticketData) async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.post('/support/tickets', data: ticketData);
  }

  @override
  Future<List<Map<String, dynamic>>> getSubscriptionPlans() async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.get('/subscriptions/plans');
    // return List<Map<String, dynamic>>.from(response.data['data']);
    return [
      {
        'id': '1',
        'name': 'Basic',
        'price': 99.0,
        'duration': '1 Month',
        'features': ['5 Orders/month', 'Free Delivery'],
      },
      {
        'id': '2',
        'name': 'Premium',
        'price': 199.0,
        'duration': '1 Month',
        'features': ['Unlimited Orders', 'Free Delivery', 'Priority Support'],
      },
    ];
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
