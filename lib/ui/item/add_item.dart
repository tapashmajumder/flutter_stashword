import 'package:Stashword/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddItemWidget extends HookConsumerWidget {
  const AddItemWidget({super.key});

  AppBar createAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          ref.read(providers.addItemStateProvider.notifier).state = AddItemState.none;
          Navigator.of(context).pop();
        },
      ),
      title: const Text("Add Item"),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(providers.addItemStateProvider.notifier).state = AddItemState.none;
            Navigator.of(context).pop();
          },
          child: const Text("Add", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 15, // Set the total number of items
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150.0, // Maximum width of each cell
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
          childAspectRatio: 1.0, // Width to height ratio of each cell
        ),
        itemBuilder: (BuildContext context, int index) {
          // Build each item in the collection view
          return Container(
            color: Colors.blue, // Example item styling
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
