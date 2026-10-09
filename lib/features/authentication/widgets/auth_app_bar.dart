import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Centered title header shared by the authentication screens: a back button
/// on the start (right) side and an optional help button on the end (left)
/// side. Expects an RTL [Directionality] ancestor.
class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.backIcon = Icons.arrow_back,
    this.onHelpTap,
  });

  final String title;
  final String? subtitle;

  /// Mirrored by RTL, so [Icons.arrow_back] and [Icons.chevron_left] point
  /// right.
  final IconData backIcon;

  /// Shows the help button when set.
  final VoidCallback? onHelpTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: preferredSize.height,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leadingWidth: 68,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: AuthCircleIconButton(
          icon: Icon(backIcon, size: 20, color: colorScheme.onSurface),
          onTap: () {
            if (context.canPop()) context.pop();
          },
        ),
      ),
      actions: [
        if (onHelpTap != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: AuthCircleIconButton(
              // The question mark must not be mirrored by RTL.
              icon: Icon(
                Icons.help_outline,
                size: 20,
                color: colorScheme.onSurfaceVariant,
                textDirection: TextDirection.ltr,
              ),
              onTap: onHelpTap!,
            ),
          ),
      ],
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          if (subtitle != null) ...[
            const Gap(2),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
      shape: Border(bottom: BorderSide(color: colorScheme.outline)),
    );
  }
}

class AuthCircleIconButton extends StatelessWidget {
  const AuthCircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.outlineVariant,
            border: Border.all(color: context.colorScheme.outline),
          ),
          child: icon,
        ),
      ),
    );
  }
}
