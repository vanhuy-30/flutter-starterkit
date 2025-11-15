import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_button.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// Onboarding Carousel
/// Interactive onboarding screens with carousel navigation
class OnboardingCarousel extends StatefulWidget {
  final List<OnboardingPage> pages;
  final VoidCallback? onComplete;
  final VoidCallback? onSkip;
  final String skipText;
  final String nextText;
  final String getStartedText;
  final bool showSkipButton;
  final bool showNextButton;
  final bool showGetStartedButton;
  final Color? indicatorColor;
  final Color? activeIndicatorColor;
  final double? indicatorSize;

  const OnboardingCarousel({
    super.key,
    required this.pages,
    this.onComplete,
    this.onSkip,
    this.skipText = 'Bỏ qua',
    this.nextText = 'Tiếp theo',
    this.getStartedText = 'Bắt đầu',
    this.showSkipButton = true,
    this.showNextButton = true,
    this.showGetStartedButton = true,
    this.indicatorColor,
    this.activeIndicatorColor,
    this.indicatorSize = 8.0,
  });

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildSkipButton(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: widget.pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(widget.pages[index]);
                },
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    if (!widget.showSkipButton) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: widget.onSkip,
          child: AppText(
            widget.skipText,
            color: AppColors.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image or Icon
          if (page.image != null) ...[
            page.image!,
            const SizedBox(height: 48),
          ] else if (page.icon != null) ...[
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: (page.iconColor ?? AppColors.primaryColor)
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: AppIcon(
                icon: page.icon,
                color: page.iconColor ?? AppColors.primaryColor,
                size: 60,
              ),
            ),
            const SizedBox(height: 48),
          ],

          // Title
          AppAutoSizeText(
            page.title,
            maxFontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryColor,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Description
          AppAutoSizeText(
            page.description,
            maxFontSize: 16,
            color: AppColors.textSecondaryColor,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          // Page indicators
          _buildPageIndicators(),
          const SizedBox(height: 32),

          // Action buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.pages.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: widget.indicatorSize,
          height: widget.indicatorSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPage
                ? (widget.activeIndicatorColor ?? AppColors.primaryColor)
                : (widget.indicatorColor ??
                    AppColors.textSecondaryColor.withValues(alpha: 0.3)),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final isLastPage = _currentPage == widget.pages.length - 1;

    return Row(
      children: [
        if (!isLastPage && widget.showNextButton) ...[
          Expanded(
            child: AppButton(
              text: widget.nextText,
              onPressed: _nextPage,
            ),
          ),
        ] else if (isLastPage && widget.showGetStartedButton) ...[
          Expanded(
            child: AppButton(
              text: widget.getStartedText,
              onPressed: widget.onComplete ?? () {},
            ),
          ),
        ],
      ],
    );
  }

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

/// Onboarding page model
class OnboardingPage {
  final String title;
  final String description;
  final Widget? image;
  final IconData? icon;
  final Color? iconColor;

  const OnboardingPage({
    required this.title,
    required this.description,
    this.image,
    this.icon,
    this.iconColor,
  });
}

/// Specialized onboarding for app introduction
class AppOnboardingCarousel extends StatelessWidget {
  final VoidCallback? onComplete;
  final VoidCallback? onSkip;

  const AppOnboardingCarousel({
    super.key,
    this.onComplete,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingCarousel(
      pages: const [
        OnboardingPage(
          title: 'Chào mừng đến với App',
          description:
              'Khám phá những tính năng tuyệt vời và trải nghiệm dịch vụ tốt nhất.',
          icon: AppIcons.home,
          iconColor: AppColors.primaryColor,
        ),
        OnboardingPage(
          title: 'Dễ dàng sử dụng',
          description:
              'Giao diện thân thiện và trực quan giúp bạn sử dụng một cách dễ dàng.',
          icon: AppIcons.settings,
          iconColor: AppColors.successColor,
        ),
        OnboardingPage(
          title: 'Bảo mật cao',
          description:
              'Thông tin của bạn được bảo vệ an toàn với công nghệ mã hóa tiên tiến.',
          icon: AppIcons.security,
          iconColor: AppColors.warningColor,
        ),
      ],
      onComplete: onComplete,
      onSkip: onSkip,
    );
  }
}
