import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemsWidget extends HookConsumerWidget {
  const ItemsWidget({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Items', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}