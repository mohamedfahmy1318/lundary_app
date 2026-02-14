import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/wallet/data/models/family_member_model.dart';
import 'package:laundry/features/wallet/data/models/payment_card_model.dart';
import 'package:laundry/features/wallet/data/models/wallet_transaction_model.dart';

abstract class WalletRepo {
  Future<Either<Failure, double>> getBalance();
  Future<Either<Failure, List<WalletTransactionModel>>> getTransactions();
  Future<Either<Failure, void>> topUp(double amount, String cardId);
  Future<Either<Failure, List<PaymentCardModel>>> getCards();
  Future<Either<Failure, void>> addCard(Map<String, dynamic> cardData);
  Future<Either<Failure, void>> removeCard(String cardId);
  Future<Either<Failure, List<FamilyMemberModel>>> getFamilyMembers();
  Future<Either<Failure, void>> addFamilyMember(
    Map<String, dynamic> memberData,
  );
  Future<Either<Failure, void>> removeFamilyMember(String memberId);
}
