import 'package:Stashword/ui/card/cards.dart';
import 'package:Stashword/ui/doc/docs.dart';
import 'package:Stashword/ui/item/items.dart';
import 'package:Stashword/ui/responsive/responsive_widget.dart';
import 'package:Stashword/ui/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageInfo {
  final int index;
  final String name;
  final WidgetBuilder builder;

  PageInfo({
    required this.index,
    required this.name,
    required this.builder,
  });
}

final pages = <int, PageInfo>{
  0: PageInfo(index: 0, name: "Items", builder: (_) => const ItemsWidget()),
  1: PageInfo(index: 1, name: "Cards", builder: (_) => const CardsWidget()),
  2: PageInfo(index: 2, name: "Docs", builder: (_) => const DocsWidget()),
  3: PageInfo(index: 3, name: "Settings", builder: (_) => const SettingsWidget()),
};

final selectedPageIndexProvider = StateProvider<int>((ref) => 0);

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageIndex = ref.watch(selectedPageIndexProvider);
  return pages[selectedPageIndex]!.builder;
});


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// 1. extend from ConsumerWidget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // 2. add a WidgetRef argument
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. watch selectedPageBuilderProvider
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ResponsiveWidget(),
    );
  }
}

