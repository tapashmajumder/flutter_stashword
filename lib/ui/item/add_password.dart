import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/util/ace_util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddPasswordWidget extends ConsumerWidget {
  final bool showAppBar;
  final PasswordModel model;
  final nameEditingController = TextEditingController();
  final websiteEditingController = TextEditingController();
  final userNameEditingController = TextEditingController();
  final notesEditingController = TextEditingController();
  late final PasswordFormFieldWidget passwordWidget;

  AddPasswordWidget({
    required this.showAppBar,
    required this.model,
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
            )
          ],
        ),
      ),
    );
  }

  (bool, String?) _validate({
    final String? name,
    final String? website,
    final String? userName,
    final String? password,
  }) {
    if (name == null) {
      return (false, "Name can't be empty");
    } else {
      return (true, null);
    }
  }

  void _onAddTapped(BuildContext context, WidgetRef ref) {
    final name = nameEditingController.text.nullIfEmpty();
    final website = websiteEditingController.text.nullIfEmpty();
    final userName = userNameEditingController.text.nullIfEmpty();
    final password = passwordWidget.password.nullIfEmpty();
    final notes = notesEditingController.text.nullIfEmpty();

    final (valid, errorMessage) = _validate(name: name, website: website, userName: userName, password: password);
    if (!valid) {
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
      return;
    }

    final item = PasswordModel(
      id: AceUtil.newUuid(),
      iv: AceUtil.newIv(),
      name: name,
      url: website,
      userName: userName,
      password: password,
      notes: notes,
    );

    ref.read(providers.itemsProvider.notifier).addItem(item: item);
    ref.read(providers.addItemStateProvider.notifier).state = AddItemState.none;
    Navigator.of(context).pop();
  }

  AppBar _createAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          ref.read(providers.addItemStateProvider.notifier).state = AddItemState.none;
          Navigator.of(context).pop();
        },
      ),
      title: const Text("Add Password"),
      actions: [
        TextButton(
          onPressed: () => _onAddTapped(context, ref),
          child: const Text("Add", style: TextStyle(color: Colors.white)),
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
