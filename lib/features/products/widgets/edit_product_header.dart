import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Pinned top bar of the edit product screen: back chevron on the start
/// (right) side, centered "فرم محصول" title, profile avatar on the end (left)
/// side. Expects an RTL [Directionality] ancestor.
class EditProductHeader extends StatelessWidget {
  const EditProductHeader({super.key, this.onBackTap, this.onAvatarTap});

  final VoidCallback? onBackTap;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
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
              'فرم محصول',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          InkWell(
            onTap: onAvatarTap,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.outline, width: 2),
              ),
              child: Icon(
                Icons.person_rounded,
                size: 22,
                color: colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
