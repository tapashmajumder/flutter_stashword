import 'package:Stashword/ui/split_view/app_menu.dart';
import 'package:Stashword/ui/split_view/example/first_page.dart';
import 'package:flutter/material.dart';

class SplitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 600.0;
    if (screenWidth >= breakpoint) {
      // widescreen: menu on the left, content on the right
      return Row(
        children: [
          // use SizedBox to constrain the AppMenu to a fixed width
          SizedBox(
            width: 240,
            // TODO: make this configurable
            child: AppMenu(),
          ),
          // vertical black line as separator
          Container(width: 0.5, color: Colors.black),
          // use Expanded to take up the remaining horizontal space
          Expanded(
            // TODO: make this configurable
            child: FirstPage(),
          ),
        ],
      );
    } else {
      // narrow screen: show content, menu inside drawer
      return Scaffold(
        body: FirstPage(),
        // use SizedBox to contrain the AppMenu to a fixed width
        drawer: SizedBox(
          width: 240,
          child: Drawer(
            child: AppMenu(),
          ),
        ),
      );
    }
  }
}
