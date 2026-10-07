import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Top bar of the onboarding screen: the brand logo and "اعتماد پرو" on the
/// start (right) side, and "رد کردن" (or the "گام نهایی" pill on the last
/// page) on the end (left) side. Expects an RTL [Directionality] ancestor.
class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.logoIcon,
    required this.logoColor,
    required this.onLogoColor,
    required this.isLastPage,
    required this.onSkipTap,
  });

  final IconData logoIcon;
  final Color logoColor;
  final Color onLogoColor;
  final bool isLastPage;
  final VoidCallback onSkipTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: logoColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: logoColor.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              logoIcon,
              key: ValueKey(logoIcon),
              size: 20,
              color: onLogoColor,
            ),
          ),
        ),
        const Gap(10),
        Text(
          'اعتماد پرو',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isLastPage
              ? const _FinalStepPill(key: ValueKey('final'))
              : _SkipButton(key: const ValueKey('skip'), onTap: onSkipTap),
        ),
      ],
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Material(
      color: isDark ? Colors.transparent : colorScheme.surface,
      shape: StadiumBorder(side: BorderSide(color: colorScheme.outline)),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          child: Text(
            'رد کردن',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _FinalStepPill extends StatelessWidget {
  const _FinalStepPill({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: colorScheme.tertiary.withValues(alpha: isDark ? 0.12 : 0.1),
        shape: StadiumBorder(
          side: BorderSide(color: colorScheme.tertiary.withValues(alpha: 0.35)),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: colorScheme.tertiary,
              shape: BoxShape.circle,
            ),
          ),
          const Gap(6),
          Text(
            'گام نهایی',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? colorScheme.tertiary
                  : colorScheme.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
