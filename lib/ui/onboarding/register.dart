import 'package:Stashword/ui/onboarding/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterWidget extends HookConsumerWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final viewModel = ref.watch(registerViewModelProvider);

    ref.listen<bool?>(
      viewModel.existsProvider,
      (prev, exists) {
        if (exists != null && exists == false) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Complete Stashword Registration'),
              content: Text('Would you like to create a new Stashword account for ${emailController.text}?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    viewModel.onConfirmCreateNewUser();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (exists != null && exists == true) {
          viewModel.onUserExists();
        }
        // Reset the state to null after showing the dialog
        ref.read(viewModel.existsProvider.notifier).state = null;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, right: 20, bottom: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Aligns the column in the center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns the column in the center horizontally
              children: [
                const Text("You can verify your email via an authorization code that we email to you"),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 375, // Set the desired maximum width here
                  ),
                  child: TextFormField(controller: emailController,),
                ),
                const SizedBox(height: 20), // Adds some spacing between the TextFormField and the TextButton
                TextButton(
                  onPressed: () {
                    viewModel.onSendAuthorizationCode(emailController.text);
                  },
                  child: const Text("Send Authorization Code"),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
