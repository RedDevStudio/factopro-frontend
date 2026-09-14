import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/onboarding/widgets/page_view_item.dart';
import 'package:factopro/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController(initialPage: 0);
  ValueNotifier<int> currentPageIndexNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 95,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Text("اعتماد پرو", style: TextStyle(fontWeight: FontWeight.bold)),
            Image.asset(Images.splashAppbarLogo),
          ],
        ),
        leading: ElevatedButton(
          onPressed: () {},
          child: Text(
            'رد کردن',
            style: TextStyle(color: context.colorScheme.onSurface),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                currentPageIndexNotifier.value = index;
              },
              children: [
                PageViewItem(
                  imageUrl: Images.centerVisual,
                  title: 'صدور فاکتور و صندوق سریع',
                  content: 'صدور سریع فاکتور در کمتر از ۳ ثانیه، بارکدخوان پرسرعت و اتصال خودکار به کارتخوان',
                ),
                PageViewItem(
                  imageUrl: Images.centerVisual,
                  title: 'انبارداری هوشمند و کنترل تاریخ انقضا',
                  content: 'کالاها را با اسکن بارکد تعریف کنید، از فاسد شدن لبنیات جلوگیری کرده و سود واقعی را لحظه‌ای ببینید.',
                ),
                PageViewItem(
                  imageUrl: Images.centerVisual,
                  title: 'دفتر حساب نسیه و تسویه آسان',
                  content: 'حساب مشتریان همسایه و دفتری را با احترام مدیریت کنید، پیامک صورتحساب با لینک پرداخت شتابی بفرستید',
                ),
                PageViewItem(
                  imageUrl: Images.centerVisual,
                  title: 'هوش مصنوعی و تحلیل هوشمند سود و فروش',
                  content: 'با دستیار هوش مصنوعی، پرفروش‌ترین کالاها را شناسایی کنید، از کسری موجودی پیش از وقوع باخبر شوید و سود خالص روزانه را دقیق تحلیل نمایید',
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 4,
            effect: ExpandingDotsEffect(),
          ),
          ValueListenableBuilder(
            valueListenable: currentPageIndexNotifier,
            builder: (context, currentPageIndex, child) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                  bottom: 40,
                ),
                child: PrimaryButton(
                  onTap: () {
                    if (currentPageIndex < 3) {
                      pageController.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.pushNamed(AppRoute.auth.name);
                    }
                  },
                  backgroundColor: context.colorScheme.onPrimaryContainer,
                  labelTextColor: context.colorScheme.onPrimary,
                  borderColor: context.colorScheme.onPrimaryContainer,
                  labelText: 'مرحله بعدی',
                  icon: Icons.arrow_back,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
