abstract class HomeServiceCategoryEntity {
  const HomeServiceCategoryEntity();

  int get id;
  String get name;
}

abstract class HomeServiceEntity {
  const HomeServiceEntity();

  int get id;
  int get categoryId;
  String get name;
  String? get slug;
  String? get description;
  String get price;
  String? get expressPrice;
  String? get icon;
  String? get image;
  int? get estimatedHours;
  int? get sortOrder;
  bool? get isActive;
  HomeServiceCategoryEntity? get category;

  double get priceAsDouble => double.tryParse(price) ?? 0.0;
  double get expressPriceAsDouble => double.tryParse(expressPrice ?? '') ?? 0.0;
}
