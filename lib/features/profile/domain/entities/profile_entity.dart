import 'package:laundry/features/profile/domain/entities/active_subscription_entity.dart';

abstract class ProfileEntity {
  const ProfileEntity();

  int get id;
  String get name;
  String get email;
  String get phone;
  String? get walletBalance;
  String? get avatar;
  ActiveSubscriptionEntity? get activeSubscription;

  String? get fullAvatarUrl {
    final value = avatar;
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.startsWith('http')) {
      return value;
    }
    return 'https://laundry.findosystem.com/storage/$value';
  }
}
