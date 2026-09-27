import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/notifications/widgets/notification_action_button.dart';
import 'package:factopro/features/notifications/widgets/notification_card_data.dart';
import 'package:factopro/features/notifications/widgets/notification_tone_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Renders the optional bottom area of a notification card based on the
/// concrete [NotificationFooterData] type.
class NotificationCardFooter extends StatelessWidget {
  const NotificationCardFooter({super.key, required this.footer});

  final NotificationFooterData footer;

  @override
  Widget build(BuildContext context) {
    return switch (footer) {
      NotificationDocumentFooterData footer => _DocumentFooter(footer: footer),
      NotificationActionsFooterData footer => _ActionsFooter(footer: footer),
      NotificationStockFooterData footer => _StockFooter(footer: footer),
    };
  }
}

/// Tinted rounded panel that hosts the document and stock footers.
class _FooterPanel extends StatelessWidget {
  const _FooterPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline),
      ),
      child: child,
    );
  }
}

class _DocumentFooter extends StatelessWidget {
  const _DocumentFooter({required this.footer});

  final NotificationDocumentFooterData footer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return _FooterPanel(
      child: Row(
        children: [
          Icon(Icons.receipt_long_outlined, size: 16, color: colorScheme.onSurfaceVariant),
          const Gap(6),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '${footer.documentLabel} ',
                children: [
                  TextSpan(
                    text: footer.documentNumber,
                    style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
            ),
          ),
          const Gap(8),
          NotificationActionButton(data: footer.action),
        ],
      ),
    );
  }
}

class _ActionsFooter extends StatelessWidget {
  const _ActionsFooter({required this.footer});

  final NotificationActionsFooterData footer;

  @override
  Widget build(BuildContext context) {
    final actions = footer.actions;

    return Row(
      children: [
        for (final action in actions) ...[
          Expanded(child: NotificationActionButton(data: action)),
          if (action != actions.last) const Gap(10),
        ],
      ],
    );
  }
}

class _StockFooter extends StatelessWidget {
  const _StockFooter({required this.footer});

  final NotificationStockFooterData footer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return _FooterPanel(
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: LinearProgressIndicator(
              value: footer.stockRatio,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
              color: NotificationWarningColors.of(context),
              backgroundColor: colorScheme.outline,
            ),
          ),
          const Gap(8),
          Expanded(
            flex: 2,
            child: Text(
              footer.stockLabel,
              style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
            ),
          ),
          const Gap(8),
          Expanded(flex: 3, child: NotificationActionButton(data: footer.action)),
        ],
      ),
    );
  }
}
