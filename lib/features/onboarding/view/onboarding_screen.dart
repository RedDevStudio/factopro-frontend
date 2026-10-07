import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_background.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_colors.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_header.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_page.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_page_data.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// UI-only four-page onboarding flow. "رد کردن" jumps to the last page, whose
/// primary action opens store registration. The accent colors of the header
/// logo, glows, indicator and primary button blend while swiping.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pages = [
    OnboardingPageData(
      accent: OnboardingAccent.brand,
      haloAccent: OnboardingAccent.success,
      logoIcon: Icons.point_of_sale_rounded,
      heroIcon: Icons.receipt_long_outlined,
      cardTitle: 'صدور فاکتور در لحظه',
      cardSubtitle: 'کمتر از ۳ ثانیه با بارکد',
      isCardSubtitleHighlighted: true,
      infoRow: OnboardingInfoRowData(
        label: 'چاپ سریع فیش',
        value: '۱۰۰٪ آفلاین',
        showDot: true,
        isSpread: true,
      ),
      topBadge: OnboardingBadgeData(
        label: 'فوق سریع',
        icon: Icons.bolt_rounded,
        tone: OnboardingTone.warning,
      ),
      bottomBadge: OnboardingBadgeData(
        label: 'اتصال به پوز بانکی',
        icon: Icons.print_outlined,
        tone: OnboardingTone.success,
      ),
      title: 'صدور فاکتور و صندوق سریع',
      description: 'صدور سریع فاکتور در کمتر از ۳ ثانیه، بارکدخوان پرسرعت و اتصال خودکار به کارتخوان',
    ),
    OnboardingPageData(
      accent: OnboardingAccent.success,
      logoIcon: Icons.inventory_2_outlined,
      heroIcon: Icons.qr_code_scanner_rounded,
      cardTitle: 'انبارداری و موجودی زنده',
      cardSubtitle: 'ثبت بارکد با دوربین گوشی',
      infoRow: OnboardingInfoRowData(
        label: 'هشدار انقضای کالاها و کسری',
        icon: Icons.notifications_active_outlined,
        tone: OnboardingTone.warning,
      ),
      topBadge: OnboardingBadgeData(
        label: 'پشتیبانی اقلام وزنی',
        icon: Icons.scale_outlined,
      ),
      bottomBadge: OnboardingBadgeData(
        label: 'تخفیف هوشمند زمان‌دار',
        icon: Icons.discount_outlined,
      ),
      areBadgesMirrored: true,
      title: 'انبارداری هوشمند و کنترل تاریخ انقضا',
      description: 'کالاها را با اسکن بارکد تعریف کنید، از فاسد شدن لبنیات جلوگیری کرده و سود واقعی را لحظه‌ای ببینید.',
    ),
    OnboardingPageData(
      accent: OnboardingAccent.ledger,
      haloAccent: OnboardingAccent.brand,
      logoIcon: Icons.menu_book_outlined,
      heroIcon: Icons.sms_outlined,
      cardTitle: 'دفتر حساب نسیه محله',
      cardSubtitle: 'یادآوری محترمانه پیامکی',
      infoRow: OnboardingInfoRowData(
        label: 'لینک پرداخت آنلاین:',
        value: 'متصل به شتاب',
        isValueSuccess: true,
      ),
      topBadge: OnboardingBadgeData(
        label: 'پشتیبان‌گیری ابری',
        icon: Icons.cloud_done_outlined,
        tone: OnboardingTone.success,
      ),
      bottomBadge: OnboardingBadgeData(
        label: 'امنیت ۱۰۰٪ تضمین‌شده',
        icon: Icons.verified_user_outlined,
      ),
      title: 'دفتر حساب نسیه و تسویه آسان',
      description: 'حساب مشتریان همسایه و دفتری را با احترام مدیریت کنید، پیامک صورتحساب با لینک پرداخت شتابی بفرستید.',
    ),
    OnboardingPageData(
      accent: OnboardingAccent.brand,
      logoIcon: Icons.menu_book_outlined,
      heroIcon: Icons.psychology_outlined,
      cardTitle: 'دستیار هوشمند اعتماد',
      cardSubtitle: 'پیش‌بینی و تحلیل لحظه‌ای',
      infoRow: OnboardingInfoRowData(
        label: 'رشد فروش تخمینی:',
        value: '+۳۲٪ این ماه',
        isValueSuccess: true,
        tone: OnboardingTone.info,
      ),
      topBadge: OnboardingBadgeData(
        label: 'پیش‌بینی فروش هوشمند',
        icon: Icons.insights_rounded,
        tone: OnboardingTone.info,
      ),
      bottomBadge: OnboardingBadgeData(
        label: 'پیشنهاد هوشمند موجودی',
        icon: Icons.auto_awesome_outlined,
        tone: OnboardingTone.success,
      ),
      title: 'هوش مصنوعی و تحلیل هوشمند سود و فروش',
      description: 'با دستیار هوش مصنوعی، پرفروش‌ترین کالاها را شناسایی کنید، از کسری موجودی پیش از وقوع باخبر شوید و سود خالص روزانه را دقیق تحلیل نمایید.',
    ),
  ];

  static const _pageTransitionDuration = Duration(milliseconds: 400);

  final _pageController = PageController();
  int _currentPage = 0;

  bool get _isLastPage => _currentPage == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// The fractional page while swiping, or [_currentPage] before the
  /// [PageView] is laid out.
  double get _pagePosition {
    final controller = _pageController;
    if (controller.hasClients && controller.position.haveDimensions) {
      return controller.page ?? _currentPage.toDouble();
    }
    return _currentPage.toDouble();
  }

  /// Blends the per-page [resolve]d colors of the two pages around
  /// [_pagePosition].
  Color _blendedColor(Color Function(BuildContext, OnboardingAccent) resolve) {
    final position = _pagePosition.clamp(0, _pages.length - 1).toDouble();
    final from = position.floor();
    final to = position.ceil();
    return Color.lerp(
      resolve(context, _pages[from].accent),
      resolve(context, _pages[to].accent),
      position - from,
    )!;
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: _pageTransitionDuration,
      curve: Curves.easeInOutCubic,
    );
  }

  void _skipToLastPage() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: _pageTransitionDuration,
      curve: Curves.easeInOutCubic,
    );
  }

  void _startStoreSetup() {
    context.pushNamed(AppRoute.userStoreRegistration.name);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final page = _pages[_currentPage];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        body: ListenableBuilder(
          listenable: _pageController,
          builder: (context, child) {
            final accent = _blendedColor(OnboardingColors.accentOf);
            final onAccent = _blendedColor(OnboardingColors.onAccentOf);

            return Stack(
              children: [
                Positioned.fill(child: OnboardingBackground(accent: accent)),
                SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                            child: OnboardingHeader(
                              logoIcon: page.logoIcon,
                              logoColor: accent,
                              onLogoColor: onAccent,
                              isLastPage: _isLastPage,
                              onSkipTap: _skipToLastPage,
                            ),
                          ),
                          Expanded(child: child!),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: _pages.length,
                            onDotClicked: (index) =>
                                _pageController.animateToPage(
                                  index,
                                  duration: _pageTransitionDuration,
                                  curve: Curves.easeInOutCubic,
                                ),
                            effect: ExpandingDotsEffect(
                              dotWidth: 8,
                              dotHeight: 8,
                              spacing: 6,
                              expansionFactor: 4,
                              activeDotColor: accent,
                              dotColor: OnboardingColors.inactiveDotOf(context),
                            ),
                          ),
                          const Gap(24),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                            child: Column(
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: accent.withValues(alpha: 0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: PrimaryButton(
                                    onTap: _isLastPage
                                        ? _startStoreSetup
                                        : _goToNextPage,
                                    labelText: _isLastPage
                                        ? 'شروع و راه‌اندازی فروشگاه'
                                        : 'مرحله بعدی',
                                    labelFontSize: 16,
                                    backgroundColor: accent,
                                    borderColor: accent,
                                    labelTextColor: onAccent,
                                    // Points left in RTL, toward the next page.
                                    icon: Icons.arrow_forward_rounded,
                                    isIconAtEnd: true,
                                  ),
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                  child: _isLastPage
                                      ? const Padding(
                                          padding: EdgeInsets.only(top: 12),
                                          // No sign-in screen exists yet.
                                          child: OnboardingSecondaryButton(
                                            label: 'قبلا ثبت نام کرده‌اید؟ ورود به حساب',
                                          ),
                                        )
                                      : const SizedBox(width: double.infinity),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) =>
                OnboardingPage(page: _pages[index]),
          ),
        ),
      ),
    );
  }
}
