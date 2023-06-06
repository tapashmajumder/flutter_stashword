import 'package:Stashword/main.dart';
import 'package:Stashword/ui/split_view/page_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DesktopScaffold extends HookConsumerWidget {
  const DesktopScaffold({super.key, required this.menuWidth});

  final double menuWidth;

  void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
    if (ref.read(selectedPageNameProvider.notifier).state != pageName) {
      ref.read(selectedPageNameProvider.notifier).state = pageName;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageName = ref.watch(selectedPageNameProvider);
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: menuWidth,
            child: Scaffold(
                appBar: AppBar(),
                body: Drawer(
                  child: Column(children: [
                    const DrawerHeader(child: Icon(Icons.favorite)),
                    for (var pageName in availablePages.keys)
                      PageListTile(
                        selectedPageName: selectedPageName,
                        pageName: pageName,
                        onPressed: () => _selectPage(context, ref, pageName),
                      ),
                  ]),
                ),
            ),
          ),
          Container(width: 0.5, color: Colors.black),
          Expanded(
              child: Scaffold(
                  appBar: AppBar(title: Text(selectedPageName)),
                  body: selectedPageBuilder(context),
              ),
          ),
        ],
      ),
    );
  }
}
