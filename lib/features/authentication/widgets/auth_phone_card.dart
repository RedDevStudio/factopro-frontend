import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/authentication/widgets/auth_section_card.dart';
import 'package:factopro/features/authentication/widgets/custom_text_field.dart';
import 'package:factopro/features/authentication/widgets/send_code_button.dart';
import 'package:flutter/material.dart';

/// "شماره تلفن همراه" card with the phone field and its embedded send-code
/// button.
class AuthPhoneCard extends StatelessWidget {
  const AuthPhoneCard({
    super.key,
    required this.controller,
    required this.sendLabel,
    required this.onSend,
    this.sendColor,
    this.caption,
  });

  final TextEditingController controller;
  final String sendLabel;
  final VoidCallback onSend;
  final Color? sendColor;

  /// Muted text on the end side of the header, e.g. "مدیر فروشگاه".
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return AuthSectionCard(
      icon: Icons.phone_android,
      title: 'شماره تلفن همراه',
      trailing: caption == null
          ? null
          : Text(
              caption!,
              style: TextStyle(
                fontSize: 11,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
      child: CustomTextField(
        controller: controller,
        title: 'شماره تلفن همراه',
        showLabel: false,
        hintText: '۰۹۱۲ ۳۴۵ ۶۷۸۹',
        keyboardType: TextInputType.phone,
        textDirection: TextDirection.ltr,
        trailing: SendCodeButton(
          label: sendLabel,
          onTap: onSend,
          color: sendColor,
        ),
      ),
    );
  }
}
