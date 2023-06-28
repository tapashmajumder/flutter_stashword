import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/responsive/page_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MobileScaffold extends HookConsumerWidget {
  const MobileScaffold({super.key});

  void _selectPage(BuildContext context, WidgetRef ref, int tabIndex) {
    if (ref.read(selectedPageIndexProvider.notifier).state != tabIndex) {
      ref.read(selectedPageIndexProvider.notifier).state = tabIndex;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageIndex = ref.watch(selectedPageIndexProvider);
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);

    return Scaffold(
      appBar: AppBar(title: Text(pages[selectedPageIndex]!.name)),
      drawer: Drawer(
        child: Column(children: [
          const DrawerHeader(child: Icon(Icons.favorite)),
          for (var pageIndex in pages.keys)
            PageListTile(
              tabIndex: pageIndex,
              selectedPageIndex: selectedPageIndex,
              pageName: pages[pageIndex]!.name,
              onPressed: () => _selectPage(context, ref, pageIndex),
            ),
        ]),
      ),
      body: selectedPageBuilder(context),
    );
  }
}
