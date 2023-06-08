import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DocWidget extends HookConsumerWidget {
  const DocWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Docs', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}