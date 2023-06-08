import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DocsWidget extends HookConsumerWidget {
  const DocsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Documents', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}