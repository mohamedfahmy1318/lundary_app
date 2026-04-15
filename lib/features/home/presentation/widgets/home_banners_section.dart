import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/features/home/domain/entities/home_banner_entity.dart';
import 'package:laundry/features/home/presentation/cubit/home_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_state.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBannersSection extends StatefulWidget {
  const HomeBannersSection({super.key});

  @override
  State<HomeBannersSection> createState() => _HomeBannersSectionState();
}

class _HomeBannersSectionState extends State<HomeBannersSection> {
  static const _invalidLinkMessage =
      'This banner does not have a valid link yet.';
  static const _openLinkErrorMessage = 'Unable to open this link right now.';

  int _currentIndex = 0;
  int? _openingBannerId;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  Uri? _buildLaunchUri(String? rawLink) {
    final trimmed = rawLink?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }

    Uri? uri = Uri.tryParse(trimmed);
    if (uri == null) {
      return null;
    }

    if (!uri.hasScheme) {
      uri = Uri.tryParse('https://$trimmed');
    }

    if (uri == null || uri.host.isEmpty) {
      return null;
    }

    return uri;
  }

  void _showInfo(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onPageChanged(int index) {
    if (_currentIndex == index) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _onBannerTap(HomeBannerEntity banner, Uri? uri) async {
    if (uri == null) {
      _showInfo(_invalidLinkMessage);
      return;
    }

    await _openBannerLink(banner, uri);
  }

  Future<void> _openBannerLink(HomeBannerEntity banner, Uri uri) async {
    if (_openingBannerId == banner.id) {
      return;
    }

    setState(() {
      _openingBannerId = banner.id;
    });

    try {
      final opened = await _tryLaunchUri(uri);
      if (!opened) {
        _showInfo(_openLinkErrorMessage);
      }
    } catch (_) {
      _showInfo(_openLinkErrorMessage);
    } finally {
      if (mounted) {
        setState(() {
          _openingBannerId = null;
        });
      }
    }
  }

  Future<bool> _tryLaunchUri(Uri uri) async {
    final openedInApp = await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    if (openedInApp) {
      return true;
    }

    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _buildBannerCarousel(List<HomeBannerEntity> banners) {
    final shouldShowIndicators = banners.length > 1;

    return Column(
      children: [
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final banner = banners[index];
              final launchUri = _buildLaunchUri(banner.link);

              return HomeBannerTile(
                banner: banner,
                hasLink: launchUri != null,
                isOpening: _openingBannerId == banner.id,
                onTap: () => _onBannerTap(banner, launchUri),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        if (shouldShowIndicators)
          HomeBannerDotsIndicator(
            itemCount: banners.length,
            activeIndex: _currentIndex,
          ),
        if (shouldShowIndicators) SizedBox(height: 24.h),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (_, banners) {
            if (banners.isEmpty) {
              return const SizedBox.shrink();
            }

            return _buildBannerCarousel(banners);
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class HomeBannerTile extends StatelessWidget {
  final HomeBannerEntity banner;
  final bool hasLink;
  final bool isOpening;
  final VoidCallback onTap;

  const HomeBannerTile({
    super.key,
    required this.banner,
    required this.hasLink,
    required this.isOpening,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: isOpening ? null : onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.primary,
              image: DecorationImage(
                image: NetworkImage(banner.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                if (hasLink) const _BannerLinkBadge(),
                if (isOpening)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerLinkBadge extends StatelessWidget {
  const _BannerLinkBadge();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12.w,
      top: 12.h,
      child: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(100),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(Icons.open_in_new, color: Colors.white, size: 16.sp),
      ),
    );
  }
}

class HomeBannerDotsIndicator extends StatelessWidget {
  final int itemCount;
  final int activeIndex;

  const HomeBannerDotsIndicator({
    super.key,
    required this.itemCount,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: activeIndex == index ? 24.w : 8.w,
          height: 8.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color:
                activeIndex == index
                    ? AppColors.primary
                    : AppColors.primaryLight,
          ),
        ),
      ),
    );
  }
}
