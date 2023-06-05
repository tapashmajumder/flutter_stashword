import 'package:Stashword/ui/split_view/page_scaffold.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Second Page',
      body: Center(
        child: Text('Second Page', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}