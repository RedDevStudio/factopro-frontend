import 'package:factopro/core/common_widgets/primary_button.dart';
import 'package:factopro/core/routing/app_router.dart';
import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:factopro/features/authentication/widgets/auth_app_bar.dart';
import 'package:factopro/features/authentication/widgets/auth_notice_card.dart';
import 'package:factopro/features/authentication/widgets/auth_otp_card.dart';
import 'package:factopro/features/authentication/widgets/auth_phone_card.dart';
import 'package:factopro/features/authentication/widgets/countdown_builder.dart';
import 'package:factopro/features/authentication/widgets/otp_code_input.dart';
import 'package:factopro/features/authentication/widgets/resend_code_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Step 2 of store setup. Starts with the phone field and a locked code card;
/// after "دریافت کد" it switches to the large code-entry state.
class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  static const _resendDelay = Duration(seconds: 105);

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isCodeSent = false;

  /// Bumped on every send so [CountdownBuilder] restarts.
  int _sendCount = 0;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _sendCode() {
    setState(() {
      _isCodeSent = true;
      _sendCount++;
      _codeController.clear();
    });
  }

  void _editPhone() => setState(() => _isCodeSent = false);

  void _enterStore() => context.goNamed(AppRoute.dashboard.name);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    // The design uses navy for the main actions in light mode and the vivid
    // blue in dark mode, where the navy secondary role is indigo instead.
    final actionColor = colorScheme.brightness == Brightness.dark
        ? colorScheme.primary
        : colorScheme.secondary;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        appBar: AuthAppBar(
          title: 'تایید و احراز شماره همراه',
          subtitle: 'مرحله ۲ از ۲ • راه‌اندازی فروشگاه',
          onHelpTap: () {},
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _HeaderIcon(),
                const Gap(20),
                if (_isCodeSent)
                  _CodeEntrySection(
                    phone: _phoneController.text,
                    codeController: _codeController,
                    onEditPhone: _editPhone,
                  )
                else
                  _PhoneEntrySection(
                    phoneController: _phoneController,
                    sendColor: actionColor,
                    onSend: _sendCode,
                  ),
                const Gap(20),
                CountdownBuilder(
                  key: ValueKey(_sendCount),
                  duration: _resendDelay,
                  builder: (context, remaining) =>
                      ResendCodeCard(remaining: remaining, onResend: _sendCode),
                ),
                const Gap(16),
                const AuthNoticeCard(
                  tone: AuthNoticeTone.success,
                  icon: Icons.verified_user_outlined,
                  text: 'با تایید شماره، پیامک فاکتور مشتریان و لینک پرداخت به نام فروشگاه شما ارسال خواهد شد.',
                ),
                const Gap(24),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: actionColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: PrimaryButton(
                    onTap: _enterStore,
                    labelText: 'تایید کد و ورود به فروشگاه',
                    labelFontSize: 17,
                    // Points left in RTL, toward the next step.
                    icon: Icons.arrow_forward,
                    isIconAtEnd: true,
                    backgroundColor: actionColor,
                    borderColor: actionColor,
                    labelTextColor: colorScheme.onPrimary,
                  ),
                ),
                const Gap(14),
                _OfflineLoginButton(onTap: _enterStore),
                const Gap(14),
                const AuthNoticeCard(
                  tone: AuthNoticeTone.warning,
                  icon: Icons.warning_amber_rounded,
                  text: 'توجه: در صورت ورود آفلاین، داده‌ها فقط روی این دستگاه ذخیره می‌شوند و در فضای ابری همگام‌سازی نخواهند شد.',
                ),
                const Gap(20),
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurfaceVariant,
                    ),
                    icon: const Icon(Icons.headset_mic_outlined, size: 18),
                    label: const Text(
                      'کد پیامک نشد؟ پشتیبانی تلفنی فوری',
                      style: TextStyle(fontSize: 13),
                    ),
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

/// Chat-check icon tile with the green "verified" badge.
class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(
              Icons.mark_chat_read_outlined,
              size: 36,
              color: colorScheme.primary,
            ),
          ),
          PositionedDirectional(
            bottom: -6,
            end: -6,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: colorScheme.tertiary,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.surface, width: 2.5),
              ),
              child: Icon(Icons.check, size: 16, color: colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Initial state: phone field plus a locked code card.
class _PhoneEntrySection extends StatelessWidget {
  const _PhoneEntrySection({
    required this.phoneController,
    required this.sendColor,
    required this.onSend,
  });

  final TextEditingController phoneController;
  final Color sendColor;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final mutedStyle = TextStyle(
      fontSize: 12,
      color: colorScheme.onSurfaceVariant,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Title('ورود و احراز شماره همراه'),
        const Gap(10),
        Text(
          'برای اتصال به فضای ابری شماره خود را وارد و «دریافت کد تایید» را بزنید؛ یا مستقیما از گزینه «ورود آفلاین» استفاده کنید.',
          textAlign: TextAlign.center,
          style: mutedStyle.copyWith(fontSize: 13, height: 1.8),
        ),
        const Gap(24),
        AuthPhoneCard(
          controller: phoneController,
          caption: 'مدیر فروشگاه',
          sendLabel: 'دریافت کد',
          sendColor: sendColor,
          onSend: onSend,
        ),
        const Gap(16),
        AuthOtpCard(
          enabled: false,
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Text(
              'پس از دریافت کد وارد کنید',
              style: mutedStyle.copyWith(fontSize: 10),
            ),
          ),
          footer: Text(
            'پیامک پس از فشردن «دریافت کد» ارسال می‌شود',
            style: mutedStyle,
          ),
        ),
      ],
    );
  }
}

/// Code-sent state: the masked phone chip and the large code boxes.
class _CodeEntrySection extends StatelessWidget {
  const _CodeEntrySection({
    required this.phone,
    required this.codeController,
    required this.onEditPhone,
  });

  final String phone;
  final TextEditingController codeController;
  final VoidCallback onEditPhone;

  /// Groups the typed digits like the design (`۰۹۱۲ ۳۴۵ ۶۷۸۹`), falling back
  /// to the sample number when nothing was entered.
  String get _displayPhone {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) return '۰۹۱۲ ۳۴۵ ۶۷۸۹';
    final grouped =
        '${digits.substring(0, 4)} ${digits.substring(4, 7)} ${digits.substring(7)}';
    return grouped.replaceAllMapped(
      RegExp(r'\d'),
      (match) => int.parse(match[0]!).toPersianDigits(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final mutedStyle = TextStyle(
      fontSize: 12,
      color: colorScheme.onSurfaceVariant,
    );

    return Column(
      children: [
        _Title('کد تایید پیامکی را وارد کنید'),
        const Gap(10),
        Text(
          'کد تایید ۵ رقمی به شماره همراه مدیر فروشگاه ارسال شد:',
          textAlign: TextAlign.center,
          style: mutedStyle.copyWith(fontSize: 13),
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 6, 6, 6),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.phone_android,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              const Gap(6),
              Text(
                _displayPhone,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Gap(8),
              Container(width: 1, height: 16, color: colorScheme.outline),
              TextButton(
                onPressed: onEditPhone,
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'ویرایش',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(24),
        Text(
          'کد ارسالی ۵ رقمی',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const Gap(12),
        OtpCodeInput(
          controller: codeController,
          autofocus: true,
          boxWidth: 56,
          boxHeight: 60,
        ),
        const Gap(12),
        Text(
          'پیامک معمولا کمتر از ۳۰ ثانیه به دست شما می‌رسد',
          style: mutedStyle,
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onSurface,
      ),
    );
  }
}

/// Low-emphasis "ورود آفلاین و بدون کد تایید" button.
class _OfflineLoginButton extends StatelessWidget {
  const _OfflineLoginButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: BorderSide(color: colorScheme.outline),
    );

    return Material(
      color: isDark
          ? colorScheme.primaryContainer.withValues(alpha: 0.4)
          : colorScheme.outlineVariant,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              const Gap(8),
              Text(
                'ورود آفلاین و بدون کد تایید',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
