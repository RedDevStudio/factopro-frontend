import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/core/utils/extensions/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Row of one-digit boxes backed by a single invisible [TextField]. Digits
/// fill left-to-right like the code itself and are shown in Persian.
class OtpCodeInput extends StatefulWidget {
  const OtpCodeInput({
    super.key,
    this.controller,
    this.length = 5,
    this.enabled = true,
    this.autofocus = false,
    this.boxWidth = 46,
    this.boxHeight = 46,
  });

  final TextEditingController? controller;
  final int length;
  final bool enabled;
  final bool autofocus;
  final double boxWidth;
  final double boxHeight;

  @override
  State<OtpCodeInput> createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput> {
  TextEditingController? _ownController;
  final _focusNode = FocusNode();

  TextEditingController get _controller =>
      widget.controller ?? (_ownController ??= TextEditingController());

  @override
  void dispose() {
    _focusNode.dispose();
    _ownController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([_controller, _focusNode]),
      builder: (context, _) {
        final code = _controller.text;
        final hasFocus = widget.enabled && _focusNode.hasFocus;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: List.generate(
                  widget.length,
                  (index) => Flexible(
                    child: _OtpBox(
                      width: widget.boxWidth,
                      height: widget.boxHeight,
                      digit: index < code.length
                          ? code[index].parseLocalizedInt()?.toPersianDigits()
                          : null,
                      enabled: widget.enabled,
                      showPlaceholder: !hasFocus,
                      isActive: hasFocus && index == code.length,
                      isLatest: hasFocus && index == code.length - 1,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    autofocus: widget.autofocus,
                    keyboardType: TextInputType.number,
                    maxLength: widget.length,
                    showCursor: false,
                    enableInteractiveSelection: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9۰-۹٠-٩]')),
                    ],
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.width,
    required this.height,
    required this.digit,
    required this.enabled,
    required this.showPlaceholder,
    required this.isActive,
    required this.isLatest,
  });

  final double width;
  final double height;
  final String? digit;
  final bool enabled;
  final bool showPlaceholder;

  /// The box the next typed digit goes into.
  final bool isActive;

  /// The most recently typed digit.
  final bool isLatest;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final isFilled = digit != null;

    final Color background;
    if (isActive) {
      background = isDark
          ? colorScheme.primary.withValues(alpha: 0.12)
          : colorScheme.surface;
    } else if (isFilled) {
      background = colorScheme.surface;
    } else {
      background = colorScheme.outlineVariant;
    }

    final BorderSide border;
    if (isActive) {
      border = BorderSide(color: colorScheme.primary, width: 2);
    } else if (isLatest) {
      border = BorderSide(color: colorScheme.primary, width: 1.5);
    } else {
      border = BorderSide(color: colorScheme.outline, width: 1.5);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      constraints: BoxConstraints(maxWidth: width),
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.fromBorderSide(border),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.25),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: Text(
        digit ?? (showPlaceholder ? '-' : ''),
        style: TextStyle(
          fontSize: isFilled ? 22 : 18,
          fontWeight: FontWeight.bold,
          color: isFilled
              ? colorScheme.onSurface
              : colorScheme.onSurfaceVariant.withValues(
                  alpha: enabled ? 0.8 : 0.5,
                ),
        ),
      ),
    );
  }
}
