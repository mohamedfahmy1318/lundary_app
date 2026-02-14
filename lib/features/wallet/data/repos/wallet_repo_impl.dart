import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/wallet/data/data_sources/wallet_remote_data_source.dart';
import 'package:laundry/features/wallet/data/models/family_member_model.dart';
import 'package:laundry/features/wallet/data/models/payment_card_model.dart';
import 'package:laundry/features/wallet/data/models/wallet_transaction_model.dart';
import 'package:laundry/features/wallet/domain/repos/wallet_repo.dart';

class WalletRepoImpl implements WalletRepo {
  final WalletRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  WalletRepoImpl({
    required WalletRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, double>> getBalance() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final balance = await _remoteDataSource.getBalance();
      return Right(balance);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<WalletTransactionModel>>>
  getTransactions() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final transactions = await _remoteDataSource.getTransactions();
      return Right(transactions);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> topUp(double amount, String cardId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await _remoteDataSource.topUp(amount, cardId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PaymentCardModel>>> getCards() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final cards = await _remoteDataSource.getCards();
      return Right(cards);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addCard(Map<String, dynamic> cardData) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await _remoteDataSource.addCard(cardData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeCard(String cardId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await _remoteDataSource.removeCard(cardId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<FamilyMemberModel>>> getFamilyMembers() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final members = await _remoteDataSource.getFamilyMembers();
      return Right(members);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addFamilyMember(
    Map<String, dynamic> memberData,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await _remoteDataSource.addFamilyMember(memberData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFamilyMember(String memberId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await _remoteDataSource.removeFamilyMember(memberId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
