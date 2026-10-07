import 'package:flutter/material.dart';

/// Small rounded-square icon button used in the invoice quantity steppers
/// (plus, minus and delete).
class InvoiceStepperButton extends StatelessWidget {
  const InvoiceStepperButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    this.onTap,
    this.size = 30,
    this.radius = 8,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}
