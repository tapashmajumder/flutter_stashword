import 'package:Stashword/prefs/ace_shared_prefs.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/onboarding/confirm.dart';
import 'package:Stashword/ui/onboarding/register.dart';
import 'package:Stashword/ui/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDialog = ref.watch(providers.showDialogProvider);

    useEffect(() {
      _loadPrefs(ref);
    }, []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(children: [
        const ResponsiveWidget(),
        if (showDialog == DialogType.register) const RegisterWidget(),
        if (showDialog == DialogType.confirm) const ConfirmWidget(),
      ]),
    );
  }

  void _loadPrefs(WidgetRef ref) async {
    await AcePref.init();
    final initialCheckStatus = AcePref.getValue(PrefKey.initialCheckStatus);
    if (initialCheckStatus == null || initialCheckStatus == InitialCheckStatus.enterLogin) {
      ref.read(providers.showDialogProvider.notifier).state = DialogType.register;
    }
  }
}

