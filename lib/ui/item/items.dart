import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/item/add_item.dart';
import 'package:Stashword/ui/util/mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemsWidget extends HookConsumerWidget with CustomDialogMixin {
  const ItemsWidget({
    super.key,
  });

  static ItemCell _fromModelToCell({required ItemModel item}) {
    PasswordModel passwordModel = item as PasswordModel;
    return ItemCell(
      title: passwordModel.name ?? "",
      subtitle: passwordModel.userName ?? "",
      icon: item.sharedItem
          ? CupertinoIcons.square_arrow_down
          : item.shared
              ? CupertinoIcons.square_arrow_up
              : null,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsProvider);
    final itemViewState = ref.watch(itemViewStateProvider);

    const addItemWidget = AddItemWidget();

    if (itemViewState == ItemViewState.add) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomDialog(
          context: context,
          contentWidget: addItemWidget,
          appBar: addItemWidget.createAppBar(context, ref),
        );
      });
    }

    return Scaffold(
      body: ListView(
        children: [
          for (var item in items) _fromModelToCell(item: item),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(itemViewStateProvider.notifier).state = ItemViewState.add;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemCell extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const ItemCell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.lightBlue,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              const SizedBox(width: 2.0),
            ],
          ),
        ));
  }
}
