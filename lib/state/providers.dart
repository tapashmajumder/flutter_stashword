import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/dev_providers.dart';
import 'package:Stashword/state/prod_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class IProviders {
  StateNotifierProvider<ItemsListNotifier, List<ItemModel>> get itemsProvider;

  StateProvider<ItemModel?> get selectedItemProvider;

  StateProvider<DisplayType> get displayTypeProvider;
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
