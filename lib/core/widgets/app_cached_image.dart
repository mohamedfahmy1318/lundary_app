import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:laundry/core/constants/app_colors.dart';

/// Cached network image with loading and error states built-in
///
/// Usage:
///   AppCachedImage(
///     imageUrl: 'https://example.com/image.jpg',
///     height: 200.h,
///     width: double.infinity,
///   )
///
///   AppCachedImage.circle(
///     imageUrl: user.avatar,
///     size: 48,
///   )
class AppCachedImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AppCachedImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  }) : assert(
         imageUrl != null || assetPath != null,
         'Either imageUrl or assetPath must be provided',
       );

  /// Circular image (network or asset)
  factory AppCachedImage.circle({
    Key? key,
    String? imageUrl,
    String? assetPath,
    required double size,
  }) {
    return AppCachedImage(
      key: key,
      imageUrl: imageUrl,
      assetPath: assetPath,
      width: size.w,
      height: size.w,
      borderRadius: BorderRadius.circular(size.w / 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _assetImage();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) => _placeholder(),
      errorWidget: (_, _, _) =>
          assetPath != null ? _assetImage() : _errorWidget(),
    );
  }

  Widget _assetImage() {
    return Image.asset(assetPath!, width: width, height: height, fit: fit);
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.border,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

  Widget _errorWidget() {
    return Container(
      width: width,
      height: height,
      color: AppColors.border,
      child: Icon(
        Icons.broken_image_outlined,
        color: AppColors.textHint,
        size: 32.sp,
      ),
    );
  }
}
