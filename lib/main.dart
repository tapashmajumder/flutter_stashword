import 'package:Stashword/prefs/ace_shared_prefs.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/onboarding/register.dart';
import 'package:Stashword/ui/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _shouldShowDialog(ref);
    final showDialog = ref.watch(providers.showDialogProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(children: [
        const ResponsiveWidget(),
        if (showDialog) const RegisterWidget(),
      ]),
    );
  }

  void _shouldShowDialog(WidgetRef ref) async {
    await AcePref.init();
    final initialCheckStatus = AcePref.getValue(PrefKey.initialCheckStatus);
    if (initialCheckStatus == null || initialCheckStatus == InitialCheckStatus.enterLogin) {
      ref.read(providers.showDialogProvider.notifier).state = true;
    }
  }
}

