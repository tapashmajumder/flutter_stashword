import 'package:Stashword/ui/onboarding/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfirmWidget extends HookConsumerWidget {
  const ConfirmWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Security Code"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, right: 20, bottom: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Aligns the column in the center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns the column in the center horizontally
              children: [
                const Text("Confirm the code that we emailed you."),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 50, // Set the desired maximum width here
                  ),
                  child: TextFormField(controller: emailController,),
                ),
                const SizedBox(height: 20), // Adds some spacing between the TextFormField and the TextButton
                TextButton(
                  onPressed: () {
                  },
                  child: const Text("Confirm"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
