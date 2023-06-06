import 'package:Stashword/ui/split_view/example/first_page.dart';
import 'package:Stashword/ui/split_view/example/second_page.dart';
import 'package:Stashword/ui/split_view/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// a map of ("page name", WidgetBuilder) pairs
final availablePages = <String, WidgetBuilder>{
  'F I R S T': (_) => const FirstPage(),
  'S E C O N D': (_) => const SecondPage(),
};

// this is a `StateProvider` so we can change its value
final selectedPageNameProvider = StateProvider<String>((ref) {
  // default value
  return availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  // watch for state changes inside selectedPageNameProvider
  final selectedPageKey = ref.watch(selectedPageNameProvider);
  // return the WidgetBuilder using the key as index
  return availablePages[selectedPageKey]!;
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

