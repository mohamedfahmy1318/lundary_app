class OnBoardingModel {
  final String title;
  final String description;
  final String image;
  final String? buttonText;

  OnBoardingModel({
    required this.title,
    required this.description,
    required this.image,
    this.buttonText,
  });
}
