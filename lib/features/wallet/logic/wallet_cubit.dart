import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/wallet/domain/repos/wallet_repo.dart';
import 'package:laundry/features/wallet/logic/wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepo _repo;

  WalletCubit({required WalletRepo repo})
    : _repo = repo,
      super(const WalletState.initial());

  Future<void> loadWallet() async {
    emit(const WalletState.loading());

    final balanceResult = await _repo.getBalance();
    final transactionsResult = await _repo.getTransactions();
    final cardsResult = await _repo.getCards();
    final membersResult = await _repo.getFamilyMembers();

    // If any critical call fails, emit error
    if (balanceResult.isLeft()) {
      balanceResult.fold(
        (failure) => emit(WalletState.error(failure.message)),
        (_) {},
      );
      return;
    }

    emit(
      WalletState.loaded(
        balance: balanceResult.getOrElse(() => 0),
        transactions: transactionsResult.getOrElse(() => []),
        cards: cardsResult.getOrElse(() => []),
        familyMembers: membersResult.getOrElse(() => []),
      ),
    );
  }

  Future<void> topUp(double amount, String cardId) async {
    final result = await _repo.topUp(amount, cardId);
    result.fold(
      (failure) => emit(WalletState.error(failure.message)),
      (_) => loadWallet(), // Refresh after top-up
    );
  }

  Future<void> addCard(Map<String, dynamic> cardData) async {
    final result = await _repo.addCard(cardData);
    result.fold(
      (failure) => emit(WalletState.error(failure.message)),
      (_) => loadWallet(),
    );
  }

  Future<void> removeCard(String cardId) async {
    final result = await _repo.removeCard(cardId);
    result.fold(
      (failure) => emit(WalletState.error(failure.message)),
      (_) => loadWallet(),
    );
  }

  Future<void> addFamilyMember(Map<String, dynamic> memberData) async {
    final result = await _repo.addFamilyMember(memberData);
    result.fold(
      (failure) => emit(WalletState.error(failure.message)),
      (_) => loadWallet(),
    );
  }

  Future<void> removeFamilyMember(String memberId) async {
    final result = await _repo.removeFamilyMember(memberId);
    result.fold(
      (failure) => emit(WalletState.error(failure.message)),
      (_) => loadWallet(),
    );
  }
}
