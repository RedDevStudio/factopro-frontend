import 'package:flutter/material.dart';

/// Semantic color family of a notification (icon box, unread dot, tag pill,
/// highlighted border and colored body segments).
enum NotificationTone { success, danger, warning, info }

/// How a [NotificationBodySegment] is emphasised inside the card body.
enum NotificationEmphasis { none, bold, accent }

class NotificationBodySegment {
  const NotificationBodySegment(this.text, {this.emphasis = NotificationEmphasis.none});

  final String text;
  final NotificationEmphasis emphasis;
}

/// Small pill shown under the notification title. A null [tone] renders the
/// neutral (grey) variant.
class NotificationTagData {
  const NotificationTagData({required this.label, this.tone});

  final String label;
  final NotificationTone? tone;
}

/// Visual weight of an action button inside a notification card.
enum NotificationActionStyle { filled, tonal }

class NotificationActionData {
  const NotificationActionData({
    required this.label,
    required this.icon,
    this.style = NotificationActionStyle.filled,
    this.tone,
    this.iconAtEnd = false,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final NotificationActionStyle style;

  /// For [NotificationActionStyle.filled] this is the background color (null
  /// uses the brand color). For [NotificationActionStyle.tonal] it tints the
  /// label in dark mode.
  final NotificationTone? tone;

  /// Renders [icon] after the label (i.e. on the left in RTL), used for
  /// directional arrows.
  final bool iconAtEnd;
  final VoidCallback? onTap;
}

/// The optional bottom area of a notification card.
sealed class NotificationFooterData {
  const NotificationFooterData();
}

/// A tinted panel showing a document number next to a single action.
class NotificationDocumentFooterData extends NotificationFooterData {
  const NotificationDocumentFooterData({
    required this.documentLabel,
    required this.documentNumber,
    required this.action,
  });

  final String documentLabel;
  final String documentNumber;
  final NotificationActionData action;
}

/// One or more equally sized action buttons laid out in a row.
class NotificationActionsFooterData extends NotificationFooterData {
  const NotificationActionsFooterData({required this.actions});

  final List<NotificationActionData> actions;
}

/// A tinted panel with a stock level bar and a reorder action.
class NotificationStockFooterData extends NotificationFooterData {
  const NotificationStockFooterData({
    required this.stockLabel,
    required this.stockRatio,
    required this.action,
  });

  final String stockLabel;

  /// Current stock divided by shelf capacity, in the range 0..1.
  final double stockRatio;
  final NotificationActionData action;
}

/// Static, UI-only representation of a single notification card.
class NotificationCardData {
  const NotificationCardData({
    required this.title,
    required this.timeLabel,
    required this.icon,
    required this.tone,
    required this.body,
    this.tag,
    this.isUnread = false,
    this.isHighlighted = false,
    this.footer,
  });

  final String title;
  final String timeLabel;
  final IconData icon;
  final NotificationTone tone;
  final List<NotificationBodySegment> body;
  final NotificationTagData? tag;
  final bool isUnread;

  /// Critical notifications get an accent-tinted border/background.
  final bool isHighlighted;
  final NotificationFooterData? footer;
}

/// A single option in the category chips row.
class NotificationCategoryData {
  const NotificationCategoryData({required this.label, required this.count, this.tone});

  final String label;
  final String count;

  /// Null represents the "همه" (all) category, which has no colored dot.
  final NotificationTone? tone;
}
