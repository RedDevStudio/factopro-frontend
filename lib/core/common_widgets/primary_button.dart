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
  });

  final VoidCallback onTap;
  final String labelText;
  final Color? backgroundColor;
  final Color? labelTextColor;
  final Color? borderColor;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
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
                  if (icon != null)
                    Icon(
                      icon,
                      color: labelTextColor ?? context.colorScheme.primary,
                    ),
                  if (icon != null) Gap(6),
                  Text(
                    labelText,
                    style: TextStyle(
                      color: labelTextColor ?? context.colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
