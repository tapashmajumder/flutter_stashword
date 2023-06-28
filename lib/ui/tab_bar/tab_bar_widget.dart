import 'package:Stashword/state/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabBarWidget extends HookConsumerWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageIndex = ref.watch(selectedPageIndexProvider);
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);

    return Scaffold(
      appBar: AppBar(title: Text(pages[selectedPageIndex]!.name)),
      body: selectedPageBuilder(context),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedPageIndex,
        onTap: (index) {
          ref.read(selectedPageIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.creditcard),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc),
            label: 'Docs',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.envelope),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
