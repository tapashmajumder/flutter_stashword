import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsDetailsWidget extends HookConsumerWidget {
  const SettingsDetailsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Settings', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}