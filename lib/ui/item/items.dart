import 'package:Stashword/ui/item/add_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemsWidget extends HookConsumerWidget {
  const ItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: const [
          ItemCell(
            title: 'iCloud',
            subtitle: 'user@example.com',
            icon: CupertinoIcons.square_arrow_up,
          ),
          ItemCell(
            title: 'Amazon AWS',
            subtitle: 'user@example.com',
            icon: CupertinoIcons.square_arrow_down,
          ),
          // Add more cells as needed
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        AppBar(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          automaticallyImplyLeading: false,
                          title: const Text('Add Item'),
                          actions: [
                            IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: AddItemWidget(), // Your dialog content goes here,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemCell extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ItemCell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.lightBlue,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              const SizedBox(width: 2.0),
            ],
          ),
        ));
  }
}
