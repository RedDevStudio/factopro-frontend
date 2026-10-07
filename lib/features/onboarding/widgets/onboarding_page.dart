import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_feature_card.dart';
import 'package:factopro/features/onboarding/widgets/onboarding_page_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A single onboarding page: the feature card illustration followed by the
/// centered title and description. Scrolls when the viewport is too short.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.page});

  final OnboardingPageData page;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(16),
              OnboardingFeatureCard(page: page),
              const Gap(28),
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Gap(10),
              Text(
                page.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.8,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
