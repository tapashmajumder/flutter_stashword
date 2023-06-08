import 'package:Stashword/ui/responsive/desktop_scaffold.dart';
import 'package:Stashword/ui/responsive/mobile_scaffold.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    this.breakpoint = 600,
    this.menuWidth = 290,
  }) : super(key: key);
  final double breakpoint;
  final double menuWidth;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= breakpoint) {
      return DesktopScaffold(menuWidth: menuWidth);
    } else {
      // narrow screen: show content, menu inside drawer
      return const MobileScaffold();
    }
  }
}
