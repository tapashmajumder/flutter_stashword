import 'package:flutter/material.dart';

class PageListTile extends StatelessWidget {
  const PageListTile({
    Key? key,
    required this.tabIndex,
    required this.selectedPageIndex,
    required this.pageName,
    this.onPressed,
  }) : super(key: key);
  final int tabIndex;
  final int selectedPageIndex;
  final String pageName;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Opacity(
        opacity: selectedPageIndex == tabIndex ? 1.0 : 0.0,
        child: const Icon(Icons.check),
      ),
      title: Text(pageName),
      onTap: onPressed,
    );
  }
}