import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/ui/item/view_password.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PasswordModel model = PasswordModel(
      id: "id",
      iv: "iv",
      name: "Instagram",
      url: "https://www.instagram.com",
      sharedItem: false,
      sharer: "user2@example.com",
      userName: "zee username",
      password: "zee password",
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(child: SizedBox(width: 500, height: 500, child: Scaffold(body: ViewPasswordWidget(model: model, showAppbar: false,)))),
    );
  }
}
