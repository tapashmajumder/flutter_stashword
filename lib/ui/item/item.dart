import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemWidget extends HookConsumerWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("iCloud")),
      body: Center(
        child: Text('iCloud password', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}