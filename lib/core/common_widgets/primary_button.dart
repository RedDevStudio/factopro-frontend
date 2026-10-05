import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.labelText,
    this.backgroundColor,
    this.labelTextColor,
    this.borderColor,
    this.isLoading = false,
    this.icon,
    this.labelFontSize = 20,
    this.isIconAtEnd = false,
  });

  final VoidCallback onTap;
  final String labelText;
  final Color? backgroundColor;
  final Color? labelTextColor;
  final Color? borderColor;
  final bool isLoading;
  final IconData? icon;
  final double labelFontSize;

  /// Places [icon] after the label instead of before it.
  final bool isIconAtEnd;

  @override
  Widget build(BuildContext context) {
    final iconWidget = icon == null
        ? null
        : Icon(icon, color: labelTextColor ?? context.colorScheme.primary);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
          border: BoxBorder.all(
            color: borderColor ?? context.colorScheme.primary,
            width: 2,
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(color: context.colorScheme.primary)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconWidget != null && !isIconAtEnd) ...[
                    iconWidget,
                    Gap(6),
                  ],
                  Flexible(
                    child: Text(
                      labelText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: labelTextColor ?? context.colorScheme.primary,
                        fontSize: labelFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (iconWidget != null && isIconAtEnd) ...[
                    Gap(6),
                    iconWidget,
                  ],
                ],
              ),
      ),
    );
  }
}
