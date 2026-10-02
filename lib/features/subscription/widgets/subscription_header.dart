import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_colors.dart';
import 'package:flutter/material.dart';

/// Pinned top bar of the subscription screens: back chevron and the [title]
/// on the start (right) side, help and profile avatar on the end (left) side.
/// Expects an RTL [Directionality] ancestor.
class SubscriptionHeader extends StatelessWidget {
  const SubscriptionHeader({
    super.key,
    this.title = 'ارتقا و تمدید اشتراک',
    this.onBackTap,
    this.onHelpTap,
    this.onAvatarTap,
  });

  final String title;
  final VoidCallback? onBackTap;
  final VoidCallback? onHelpTap;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackTap,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          IconButton(
            onPressed: onHelpTap,
            icon: Icon(
              Icons.help_outline_rounded,
              size: 24,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: onAvatarTap,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: SubscriptionColors.accentOf(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_outline_rounded,
                size: 20,
                color: SubscriptionColors.onAccentOf(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
