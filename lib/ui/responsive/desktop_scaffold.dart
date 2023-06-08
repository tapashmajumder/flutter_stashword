import 'package:Stashword/ui/item/item.dart';
import 'package:Stashword/ui/tab_bar/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DesktopScaffold extends HookConsumerWidget {
  const DesktopScaffold({super.key, required this.menuWidth});
  final double menuWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: menuWidth,
            child: const TabBarWidget(),
          ),
          Container(width: 0.5, color: Colors.black),
          const Expanded(
            child: ItemWidget(),
          ),
        ],
      ),
    );
  }
}
