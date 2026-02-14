import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/wallet/data/models/family_member_model.dart';
import 'package:laundry/features/wallet/data/models/payment_card_model.dart';
import 'package:laundry/features/wallet/data/models/wallet_transaction_model.dart';

abstract class WalletRemoteDataSource {
  Future<double> getBalance();
  Future<List<WalletTransactionModel>> getTransactions();
  Future<void> topUp(double amount, String cardId);
  Future<List<PaymentCardModel>> getCards();
  Future<void> addCard(Map<String, dynamic> cardData);
  Future<void> removeCard(String cardId);
  Future<List<FamilyMemberModel>> getFamilyMembers();
  Future<void> addFamilyMember(Map<String, dynamic> memberData);
  Future<void> removeFamilyMember(String memberId);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  // ignore: unused_field
  final ApiClient _apiClient;

  WalletRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<double> getBalance() async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.get('/wallet/balance');
    // return (response.data['data']['balance'] as num).toDouble();
    return 250.00;
  }

  @override
  Future<List<WalletTransactionModel>> getTransactions() async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.get('/wallet/transactions');
    // final List<dynamic> data = response.data['data'];
    // return data.map((j) => WalletTransactionModel.fromJson(j)).toList();
    return WalletTransactionModel.mockTransactions;
  }

  @override
  Future<void> topUp(double amount, String cardId) async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.post('/wallet/topup/initiate', data: {
    //   'amount': amount,
    //   'card_id': cardId,
    // });
  }

  @override
  Future<List<PaymentCardModel>> getCards() async {
    // TODO: Replace with actual API endpoint
    return PaymentCardModel.mockCards;
  }

  @override
  Future<void> addCard(Map<String, dynamic> cardData) async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.post('/wallet/cards', data: cardData);
  }

  @override
  Future<void> removeCard(String cardId) async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.delete('/wallet/cards/$cardId');
  }

  @override
  Future<List<FamilyMemberModel>> getFamilyMembers() async {
    // TODO: Replace with actual API endpoint
    return FamilyMemberModel.mockMembers;
  }

  @override
  Future<void> addFamilyMember(Map<String, dynamic> memberData) async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.post('/wallet/family', data: memberData);
  }

  @override
  Future<void> removeFamilyMember(String memberId) async {
    // TODO: Replace with actual API endpoint
    // await _apiClient.delete('/wallet/family/$memberId');
  }
}
