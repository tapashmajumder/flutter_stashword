import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterWidget extends HookConsumerWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Email"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, right: 20, bottom: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Aligns the column in the center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns the column in the center horizontally
              children: [
                Text("You can verify your email via an authorization code that we email to you"),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 300, // Set the desired maximum width here
                  ),
                  child: TextFormField(),
                ),
                SizedBox(height: 20), // Adds some spacing between the TextFormField and the TextButton
                TextButton(
                  onPressed: () => {},
                  child: Text("Send Authorization Code"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
