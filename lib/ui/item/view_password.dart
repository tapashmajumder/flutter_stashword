import 'package:Stashword/model/item_models.dart';
import 'package:flutter/material.dart';

class ViewPasswordWidget extends StatelessWidget {
  final PasswordModel model;

  const ViewPasswordWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ViewTopWidget(
          model: model,
        ),
        const SizedBox(height: 20),
        Container(height: 1, color: Colors.grey),
        ViewRowWidget(),
        Container(height: 1, color: Colors.grey),
      ]),
    );
  }
}

class ViewTopWidget extends StatelessWidget {
  final PasswordModel model;

  const ViewTopWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedByText = model.sharedItem ? "Shared by ${model.sharer}" : "";
    final shareText = model.sharedItem
        ? ""
        : model.shared
            ? "Shared"
            : "Share";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        const CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Text("AB"),
        ),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(model.name ?? "", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Text(sharedByText, style: Theme.of(context).textTheme.titleSmall),
        ]),
        Expanded(child: Container()),
        if (model.sharedItem)
          const Spacer()
        else
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(children: [
              Text(shareText, style: Theme.of(context).textTheme.titleSmall),
              const Icon(
                Icons.chevron_right,
              )
            ])
          ]),
      ]),
    );
  }
}

class ViewRowWidget extends StatelessWidget {
  const ViewRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("URL", style: Theme.of(context).textTheme.titleMedium),
          Text("https://somewhere.com1", style: Theme.of(context).textTheme.titleSmall),
        ]),
        Expanded(child: Container()),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.open_in_new),
          )
        ])
      ]),
    );
  }
}
