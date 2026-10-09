import 'package:factopro/features/authentication/widgets/auth_section_card.dart';
import 'package:factopro/features/authentication/widgets/otp_code_input.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// "کد تایید ۵ رقمی" card: the code boxes with a header [trailing] widget
/// (timer or hint chip) and a centered [footer] (resend link or hint).
class AuthOtpCard extends StatelessWidget {
  const AuthOtpCard({
    super.key,
    required this.footer,
    this.controller,
    this.trailing,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final Widget? trailing;
  final Widget footer;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AuthSectionCard(
      icon: Icons.pin_outlined,
      title: 'کد تایید ۵ رقمی',
      trailing: trailing,
      child: Column(
        children: [
          OtpCodeInput(controller: controller, enabled: enabled),
          const Gap(16),
          footer,
        ],
      ),
    );
  }
}
