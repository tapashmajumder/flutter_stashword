import 'package:Stashword/ui/card/cards.dart';
import 'package:Stashword/ui/doc/docs.dart';
import 'package:Stashword/ui/item/items.dart';
import 'package:Stashword/ui/responsive/responsive_widget.dart';
import 'package:Stashword/ui/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

