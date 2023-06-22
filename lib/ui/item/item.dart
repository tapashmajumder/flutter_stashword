import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/item/view_password.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemWidget extends HookConsumerWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(providers.selectedItemProvider);

    return Scaffold(
      appBar: AppBar(title: Text(item == null ? "" : "${item.name}")),
      body: Center(
        child: (item == null) ? const NothingSelectedWidget() : ViewPasswordWidget(model: item as PasswordModel),
      ),
    );
  }
}

class NothingSelectedWidget extends StatelessWidget {
  const NothingSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Your Stashword Vault', style: Theme.of(context).textTheme.headlineLarge);
  }
}