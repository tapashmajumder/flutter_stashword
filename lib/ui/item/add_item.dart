import 'package:flutter/material.dart';

class AddItemWidget extends StatelessWidget {
  const AddItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 15, // Set the total number of items
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150.0, // Maximum width of each cell
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
          childAspectRatio: 1.0, // Width to height ratio of each cell
        ),
        itemBuilder: (BuildContext context, int index) {
          // Build each item in the collection view
          return Container(
            color: Colors.blue, // Example item styling
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
