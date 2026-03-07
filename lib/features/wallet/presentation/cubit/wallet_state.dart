import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/wallet/data/models/family_member_model.dart';
import 'package:laundry/features/wallet/data/models/payment_card_model.dart';
import 'package:laundry/features/wallet/data/models/wallet_transaction_model.dart';

part 'wallet_state.freezed.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;
  const factory WalletState.loading() = _Loading;
  const factory WalletState.loaded({
    required double balance,
    required List<WalletTransactionModel> transactions,
    required List<PaymentCardModel> cards,
    required List<FamilyMemberModel> familyMembers,
  }) = _Loaded;
  const factory WalletState.error(String message) = _Error;
}
