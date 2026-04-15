import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/home/domain/entities/home_banner_entity.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
abstract class BannerModel extends HomeBannerEntity with _$BannerModel {
  const BannerModel._();

  const factory BannerModel({
    required int id,
    required String title,
    required String image,
    String? link,
  }) = _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
