import 'package:Stashword/model/item_models.dart';
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
          ref.read(providers.itemViewStateProvider.notifier).state = ItemViewState.view;
          Navigator.of(context).pop();
        },
      ),
      title: const Text("Add Password"),
      actions: [
        TextButton(
          onPressed: () {
            final item = PasswordModel(
              id: "id2",
              iv: "iv2",
              name: "Amazon AWS 33",
              userName: "user@example.com",
              sharedItem: true,
            );

            ref.read(providers.itemsProvider.notifier).addItem(item: item);
            ref.read(providers.itemViewStateProvider.notifier).state = ItemViewState.view;
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
              children: [
                Row(
                  children: [
                    const Expanded(child: Text("Name")),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: const InputDecoration(
                          hintText: 'Example Site',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: Text("Website")),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: const InputDecoration(
                          hintText: 'www.example.com',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: Text("Username")),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: const InputDecoration(
                          hintText: 'user@example.com',
                        ),
                      ),
                    ),
                  ],
                ),
                PasswordFormFieldWidget(),
              ],
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

class PasswordFormFieldWidget extends StatefulWidget {
  PasswordFormFieldWidget({super.key});

  @override
  State<StatefulWidget> createState() => _PasswordFormFieldState();

  String? password;
}

class _PasswordFormFieldState extends State<PasswordFormFieldWidget> {
  double progressValue = 0.0;
  String strengthText = "It Sucks!";
  TextEditingController textEditingController = TextEditingController();

  void _onPasswordChanged(String? value) {
    setState(() {
      _updatePasswordStrength(value);
    });
  }

  void _updatePasswordStrength(final String? password) {
    if (password == null) {
      progressValue = 0.0;
      strengthText = "It Sucks!";
      widget.password = null;
      return;
    }

    if (password.isEmpty) {
      progressValue = 0.0;
      strengthText = "It Sucks!";
    } else if (password.length == 1) {
      progressValue = 0.5;
      strengthText = "OK";
    } else {
      progressValue = 0.8;
      strengthText = "Awesome!";
    }
    widget.password = password;
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
            child: Text(
          "Password",
        )),
        Expanded(
            flex: 3,
            child: Column(
              children: [
                TextFormField(
                    controller: textEditingController,
                    onChanged: _onPasswordChanged,
                    decoration: const InputDecoration(
                      hintText: '\$password',
                    )),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(child: LinearProgressIndicator(value: progressValue)),
                  const SizedBox(
                    width: 8,
                  ),
                  const ElevatedButton(
                    onPressed: null,
                    child: Text('Generate'),
                  )
                ]),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      strengthText,
                      textAlign: TextAlign.left,
                    )),
                    const Expanded(child: Text(""))
                  ],
                )
              ],
            )),
      ],
    );
  }
}
