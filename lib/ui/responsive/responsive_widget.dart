import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/responsive/desktop_scaffold.dart';
import 'package:Stashword/ui/responsive/mobile_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponsiveWidget extends HookConsumerWidget {
  const ResponsiveWidget({
    Key? key,
    this.breakpoint = 600,
    this.menuWidth = 300,
  }) : super(key: key);
  final double breakpoint;
  final double menuWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final displayType = ref.read(providers.displayTypeProvider);

    if (screenWidth >= breakpoint) {
      if (displayType != DisplayType.desktop) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(providers.displayTypeProvider.notifier).state = DisplayType.desktop;
        });
      }
      return DesktopScaffold(menuWidth: menuWidth);
    } else {
      if (displayType != DisplayType.mobile) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(providers.displayTypeProvider.notifier).state = DisplayType.mobile;
        });
      }
      // narrow screen: show content, menu inside drawer
      return const MobileScaffold();
    }
  }
}
