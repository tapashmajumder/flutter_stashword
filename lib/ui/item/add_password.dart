import 'package:Stashword/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:Stashword/ui/util/mixin.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyFormNotifier extends StateNotifier<List<(String, String)>> {
  MyFormNotifier()
      : super([
          ('Name', 'Example Site'),
          ('Website', 'www.example.com'),
          ('Username', 'user@eaxample.com'),
          ('Password', '\$password'),
        ]);

  void addField() {
    final newFieldIndex = state.length + 1;
    state = [...state, ('Field $newFieldIndex', '')];
  }
}

final StateNotifierProvider<MyFormNotifier, List<(String, String)>> fieldsProvider = StateNotifierProvider((ref) => MyFormNotifier());

class AddPasswordWidget extends HookConsumerWidget with CustomDialogMixin {
  AddPasswordWidget({
    super.key,
  });

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
          ref.read(itemViewStateProvider.notifier).state = ItemViewState.view;
          Navigator.of(context).pop();
        },
      ),
      title: const Text("Add Password"),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(ItemsListNotifier.provider.notifier).addItem2();
            ref.read(itemViewStateProvider.notifier).state = ItemViewState.view;
            Navigator.of(context).pop();
          },
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldNamesNotifier = ref.watch(fieldsProvider.notifier);
    final fieldNames = ref.watch(fieldsProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Column(
              children: List.generate(fieldNames.length, (index) {
                return Row(
                  children: [
                    Expanded(child: Text(fieldNames[index].$1)),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: 'Enter ${fieldNames[index].$1}',
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 16),
            const Text(
              'Middle Section',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: fieldNamesNotifier.addField,
              child: const Text('Add Field'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Add Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: null, // Allows multiline input
              keyboardType: TextInputType.multiline, // Specifies multiline keyboard
              decoration: const InputDecoration(
                hintText: 'Enter notes',
              ),
            )
          ],
        ),
      ),
    );
  }
}
