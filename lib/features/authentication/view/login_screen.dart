import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/authentication/widgets/auth_app_bar.dart';
import 'package:factopro/features/authentication/widgets/auth_otp_card.dart';
import 'package:factopro/features/authentication/widgets/auth_phone_card.dart';
import 'package:factopro/features/authentication/widgets/countdown_builder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// "ورود به حساب کاربری": sign in to an existing store with the phone number
/// and the SMS code only.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _resendDelay = Duration(seconds: 105);

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  /// Bumped on every send so [CountdownBuilder] restarts.
  int _sendCount = 0;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _sendCode() => setState(() => _sendCount++);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        appBar: const AuthAppBar(title: 'ورود به حساب کاربری'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'ورود به حساب کاربری',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Gap(8),
                Text(
                  'شماره همراه و کد تایید دریافتی را وارد کنید',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(24),
                AuthPhoneCard(
                  controller: _phoneController,
                  sendLabel: 'ارسال کد',
                  onSend: _sendCode,
                ),
                const Gap(16),
                CountdownBuilder(
                  key: ValueKey(_sendCount),
                  duration: _resendDelay,
                  builder: (context, remaining) {
                    final canResend = remaining <= Duration.zero;

                    return AuthOtpCard(
                      controller: _codeController,
                      trailing: canResend
                          ? null
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 14,
                                  color: colorScheme.primary,
                                ),
                                const Gap(4),
                                Text(
                                  CountdownBuilder.format(remaining),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                      footer: TextButton(
                        onPressed: canResend ? _sendCode : null,
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.primary,
                          disabledForegroundColor: colorScheme.onSurfaceVariant,
                        ),
                        child: const Text(
                          'ارسال مجدد کد',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    );
                  },
                ),
                const Gap(24),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: PrimaryButton(
                    onTap: () => context.goNamed(AppRoute.dashboard.name),
                    labelText: 'ورود به حساب',
                    labelFontSize: 17,
                    // Points left in RTL, toward the app.
                    icon: Icons.arrow_forward,
                    isIconAtEnd: true,
                    backgroundColor: colorScheme.primary,
                    borderColor: colorScheme.primary,
                    labelTextColor: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
