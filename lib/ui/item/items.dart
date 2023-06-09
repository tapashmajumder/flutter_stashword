import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/item/add_edit_password.dart';
import 'package:Stashword/ui/item/item.dart';
import 'package:Stashword/ui/util/mixin.dart';
import 'package:Stashword/util/ace_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemsWidget extends HookConsumerWidget with CustomDialogMixin {
  const ItemsWidget({
    super.key,
  });

  static Widget _fromModelToCell({required BuildContext context, required WidgetRef ref, required ItemModel item, bool isSelected = false}) {
    PasswordModel passwordModel = item as PasswordModel;
    final displayType = ref.watch(providers.displayTypeProvider);

    return GestureDetector(
      onTap: () {
        ref.read(providers.selectedItemProvider.notifier).state = passwordModel;

        if (displayType == DisplayType.mobile) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WillPopScope(
                onWillPop: () async {
                  ref.read(providers.selectedItemProvider.notifier).state = null;
                  // Return true to allow the navigation to proceed, or false to prevent it
                  return true;
                },
                child: ItemWidget(),
              ),
            ),
          );
        }
      },
      child: PasswordCell(model: passwordModel, isSelected: isSelected, key: Key(passwordModel.id)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(providers.itemsProvider);
    final selectedItem = ref.watch(providers.selectedItemProvider);
    final displayType = ref.watch(providers.displayTypeProvider);

    return Scaffold(
      body: ListView(
        children: [
          for (var item in items)
            _fromModelToCell(context: context, ref: ref, item: item, isSelected: item == selectedItem && displayType != DisplayType.mobile),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final addItemWidget = AddEditPasswordWidget(
            isAddMode: true,
            showAppBar: true,
            model: PasswordModel(id: AceUtil.newUuid(), iv: AceUtil.newIv()),
          );
          if (displayType == DisplayType.mobile) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => addItemWidget));
          } else {
            showCustomDialog(
              context: context,
              contentWidget: addItemWidget,
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PasswordCell extends HookConsumerWidget {
  final PasswordModel model;
  final bool isSelected;

  const PasswordCell({Key? key, required this.model, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Dismissible(
        key: Key(model.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirm Delete'),
                content: const Text('Are you sure you want to delete this item?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Delete'),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          ref.read(providers.itemsProvider.notifier).removeItem(item: model);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(providers.selectedItemProvider.notifier).state = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item deleted'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: isSelected ? Colors.grey[300] : null,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: Text("AB"),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(model.userName ?? "", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(model.sharedItem
                    ? CupertinoIcons.square_arrow_down
                    : model.shared
                        ? CupertinoIcons.square_arrow_up
                        : null),
                const SizedBox(width: 2.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
