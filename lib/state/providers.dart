import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/dev_providers.dart';
import 'package:Stashword/state/prod_providers.dart';
import 'package:Stashword/ui/card/cards.dart';
import 'package:Stashword/ui/doc/docs.dart';
import 'package:Stashword/ui/item/items.dart';
import 'package:Stashword/ui/settings/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageInfo {
  final int index;
  final String name;
  final WidgetBuilder builder;

  PageInfo({
    required this.index,
    required this.name,
    required this.builder,
  });
}

final pages = <int, PageInfo>{
  0: PageInfo(index: 0, name: "Items", builder: (_) => const ItemsWidget()),
  1: PageInfo(index: 1, name: "Cards", builder: (_) => const CardsWidget()),
  2: PageInfo(index: 2, name: "Docs", builder: (_) => const DocsWidget()),
  3: PageInfo(index: 3, name: "Settings", builder: (_) => const SettingsWidget()),
};

final selectedPageIndexProvider = StateProvider<int>((ref) => 0);

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageIndex = ref.watch(selectedPageIndexProvider);
  return pages[selectedPageIndex]!.builder;
});

abstract class IProviders {
  StateNotifierProvider<ItemsListNotifier, List<ItemModel>> get itemsProvider;

  StateProvider<ItemModel?> get selectedItemProvider;

  StateProvider<DisplayType> get displayTypeProvider;

  StateProvider<bool> get showDialogProvider;
}

final providers = (kReleaseMode) ? ProdProviders() : DevProviders();

class ItemsListNotifier extends StateNotifier<List<ItemModel>> {
  ItemsListNotifier({List<ItemModel> values = const []}) : super(values);

  void addItem({required final ItemModel item}) {
    state = [...state, item]..sort();
  }

  void updateItem({required final ItemModel updatedItem}) {
    final index = state.indexWhere((element) => element.id == updatedItem.id);
    if (index != -1) {
      state = [...state]
        ..replaceRange(index, index + 1, [updatedItem])
        ..sort();
    }
  }

  void removeItem({required final ItemModel item}) {
    state = state.where((element) => element.id != item.id).toList();
  }
}

enum ItemViewState {
  add,
  edit,
  view,
}

enum DisplayType {
  mobile,
  desktop,
}

final searchQueryProvider = Provider<String>((ref) => '');

final searchResultsProvider = Provider<List<ItemModel>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final items = ref.watch(providers.itemsProvider);

  // Perform search logic here and return the filtered list of items
  return [];
});
