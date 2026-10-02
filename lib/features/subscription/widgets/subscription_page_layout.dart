import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:factopro/features/subscription/widgets/subscription_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shared RTL shell of the subscription screens: pinned [SubscriptionHeader],
/// a width-constrained scrollable column of [children] and an optional pinned
/// [bottomBar].
class SubscriptionPageLayout extends StatelessWidget {
  const SubscriptionPageLayout({
    super.key,
    required this.title,
    required this.children,
    this.bottomBar,
  });

  final String title;
  final List<Widget> children;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final bottomBar = this.bottomBar;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.outlineVariant,
        body: SafeArea(
          bottom: bottomBar == null,
          child: Column(
            children: [
              SubscriptionHeader(
                title: title,
                onBackTap: () {
                  if (context.canPop()) context.pop();
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: children,
                      ),
                    ),
                  ),
                ),
              ),
              ?bottomBar,
            ],
          ),
        ),
      ),
    );
  }
}
