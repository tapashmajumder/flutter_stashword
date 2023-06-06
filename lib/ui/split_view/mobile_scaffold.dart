import 'package:Stashword/main.dart';
import 'package:Stashword/ui/split_view/page_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MobileScaffold extends HookConsumerWidget {
  const MobileScaffold({super.key});

  void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
    if (ref.read(selectedPageNameProvider.notifier).state != pageName) {
      ref.read(selectedPageNameProvider.notifier).state = pageName;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageName = ref.watch(selectedPageNameProvider);
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);

    return Scaffold(
      appBar: AppBar(title: Text(selectedPageName)),
      drawer: Drawer(
        child: Column(children: [
          const DrawerHeader(child: Icon(Icons.favorite)),
          for (var pageName in availablePages.keys)
            PageListTile(
              // 4. pass the selectedPageName as an argument
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
        ]),
      ),
      body: Center(
        child: selectedPageBuilder(context),
      ),
    );
  }
}
