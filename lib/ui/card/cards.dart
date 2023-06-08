import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CardsWidget extends HookConsumerWidget {
  const CardsWidget({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Cards', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}