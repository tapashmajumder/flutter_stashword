// Just a simple placeholder widget page (this would be something more useful in a real app)
import 'package:Stashword/ui/split_view/page_scaffold.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'First Page',
      body: Center(
        child: Text('First Page', style: Theme.of(context).textTheme.headline4),
      ),
    );
  }
}