import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/item/item.dart';
import 'package:Stashword/util/ace_util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddEditPasswordWidget extends HookConsumerWidget {
  final bool isAddMode;
  final bool showAppBar;
  final PasswordModel model;
  final MyCallbacker? callbacker;
  final nameEditingController = TextEditingController();
  final websiteEditingController = TextEditingController();
  final userNameEditingController = TextEditingController();
  final notesEditingController = TextEditingController();
  late final PasswordFormFieldWidget passwordWidget;

  AddEditPasswordWidget({
    required this.isAddMode,
    required this.showAppBar,
    required this.model,
    this.callbacker,
    Key? key,
  }) : super(key: key) {
    nameEditingController.text = model.name ?? "";
    websiteEditingController.text = model.url ?? "";
    userNameEditingController.text = model.userName ?? "";
    notesEditingController.text = model.notes ?? "";
    passwordWidget = PasswordFormFieldWidget(inputPassword: model.password ?? "");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    callbacker?.callback = () => _onActionTapped(context, ref);

    return Scaffold(
      appBar: showAppBar ? _createAppBar(context, ref) : null,
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
                        controller: nameEditingController,
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
                        controller: websiteEditingController,
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
                        controller: userNameEditingController,
                        decoration: const InputDecoration(
                          hintText: 'user@example.com',
                        ),
                      ),
                    ),
                  ],
                ),
                passwordWidget,
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: notesEditingController,
              maxLines: null, // Allows multiline input
              keyboardType: TextInputType.multiline, // Specifies multiline keyboard
              decoration: const InputDecoration(
                hintText: 'Enter notes',
              ),
            ),
            // Hidden button
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                // Make the button transparent and take no space
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all<Size>(Size.zero),
              ),
              child: null,
            ),
          ],
        ),
      ),
    );
  }

  (bool, String?) _validate({
    required final PasswordModel input,
  }) {
    if (input.name == null || input.name!.isEmpty) {
      return (false, "Name can't be empty");
    } else {
      return (true, null);
    }
  }

  bool _onActionTapped(BuildContext context, WidgetRef ref) {
    final displayType = ref.watch(providers.displayTypeProvider);

    final input = _getInputValues();

    final (valid, errorMessage) = _validate(input: input);
    if (!valid) {
      _showErrorDialog(context, errorMessage);
      return false;
    }

    if (isAddMode) {
      ref.read(providers.itemsProvider.notifier).addItem(item: input);
      Navigator.of(context).pop();
    } else {
      ref.read(providers.itemsProvider.notifier).updateItem(updatedItem: input);
      if (displayType != DisplayType.mobile) {
        ref.read(providers.selectedItemProvider.notifier).state = input;
      }
    }
    return true;
  }

  PasswordModel _getInputValues() {
    return PasswordModel(
      id: isAddMode ? AceUtil.newUuid() : model.id,
      iv: isAddMode ? AceUtil.newIv() : model.iv,
      name: nameEditingController.text.nullIfEmpty(),
      url: websiteEditingController.text.nullIfEmpty(),
      userName: userNameEditingController.text.nullIfEmpty(),
      password: passwordWidget.password.nullIfEmpty(),
      notes: notesEditingController.text.nullIfEmpty(),
    );
  }

  void _showErrorDialog(BuildContext context, String? errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error saving item'),
          content: Text(errorMessage ?? "Invalid input"),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
          ],
        );
      },
    );
  }

  AppBar _createAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(isAddMode ? "Add Password" : model.name ?? ""),
      actions: [
        TextButton(
          onPressed: () => _onActionTapped(context, ref),
          child: Text(isAddMode ? "Add" : "Save", style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class PasswordFormFieldWidget extends StatefulWidget {
  final String? inputPassword;
  final textEditingController = TextEditingController();

  PasswordFormFieldWidget({Key? key, required this.inputPassword}) : super(key: key) {
    textEditingController.text = inputPassword ?? "";
  }

  @override
  State<StatefulWidget> createState() => _PasswordFormFieldState();

  String get password => textEditingController.text;
}

class _PasswordFormFieldState extends State<PasswordFormFieldWidget> {
  double progressValue = 0.0;
  String strengthText = "Weak!";

  @override
  void initState() {
    super.initState();
    _onPasswordChanged(widget.inputPassword);
  }

  void _onPasswordChanged(String? value) {
    setState(() {
      _updatePasswordStrength(value);
    });
  }

  void _updatePasswordStrength(final String? password) {
    if (password == null) {
      progressValue = 0.0;
      strengthText = "Weak!";
      return;
    }

    if (password.isEmpty) {
      progressValue = 0.0;
      strengthText = "Weak!";
    } else if (password.length == 1) {
      progressValue = 0.5;
      strengthText = "OK";
    } else {
      progressValue = 0.8;
      strengthText = "Awesome!";
    }
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
                    controller: widget.textEditingController,
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
