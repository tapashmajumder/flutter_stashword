import 'package:flutter/material.dart';

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
            onPressed: () {
            },
            icon: Icon(Icons.open_in_new),
          )
        ])
      ]),
    );
  }
}
