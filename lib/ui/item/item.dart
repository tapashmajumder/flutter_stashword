import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/ui/item/add_edit_password.dart';
import 'package:Stashword/ui/item/view_password.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

// This class is used to call a child widget method.
class MyCallbacker {
  bool Function()? callback;
}

class ItemWidget extends HookConsumerWidget {
  final isEditModeProvider = StateProvider<bool>((ref) => false);
  final callbacker = MyCallbacker();

  ItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(providers.selectedItemProvider);
    final isEditMode = ref.watch(isEditModeProvider);
    final displayType = ref.watch(providers.displayTypeProvider);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        leading: isEditMode
            ? TextButton(
                child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  ref.read(isEditModeProvider.notifier).state = false;
                },
              )
            : null,
        title: Text(item == null ? "" : "${item.name}"),
        actions: [
          TextButton(
            child: Text(isEditMode ? "Save" : "Edit", style: const TextStyle(color: Colors.white)),
            onPressed: () {
              if (isEditMode && callbacker.callback != null && callbacker.callback!()) {
                if (displayType == DisplayType.mobile) {
                  Navigator.of(context).pop();
                } else {
                  ref.read(isEditModeProvider.notifier).state = false;
                }
              } else if (!isEditMode) {
                ref.read(isEditModeProvider.notifier).state = true;
              }
            },
          ),
        ],
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final rotateAnim = Tween(begin: math.pi, end: 0.0).animate(animation);
            return AnimatedBuilder(
              animation: rotateAnim,
              child: child,
              builder: (context, child) {
                final isUnder = (ValueKey(isEditMode) != child!.key);
                var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
                tilt *= isUnder ? -1.0 : 1.0;
                final value = isUnder ? math.min(rotateAnim.value, math.pi / 2) : rotateAnim.value;
                return Transform(
                  transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                  alignment: Alignment.center,
                  child: child,
                );
              },
            );
          },
          child: isEditMode
              ? Container(
                  key: const ValueKey<bool>(true),
                  child: Center(
                    child: AddEditPasswordWidget(
                      isAddMode: false,
                      showAppBar: false,
                      model: item as PasswordModel,
                      callbacker: callbacker,
                    ),
                  ),
                )
              : Container(
                  key: const ValueKey<bool>(false),
                  child: Center(
                    child: (item == null)
                        ? const NothingSelectedWidget()
                        : ViewPasswordWidget(
                            model: item as PasswordModel,
                            showAppbar: false,
                          ),
                  ),
                ),
        ),
      ),
    );
  }
}

class NothingSelectedWidget extends StatelessWidget {
  const NothingSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Your Stashword Vault', style: Theme.of(context).textTheme.headlineLarge);
  }
}
