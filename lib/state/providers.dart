import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/dev_providers.dart';
import 'package:Stashword/state/prod_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class IProviders {
  StateNotifierProvider<ItemsListNotifier, List<ItemModel>> get itemsProvider;
  StateProvider<ItemViewState> get itemViewStateProvider;
  Provider<ItemModel?> get selectedItemProvider;
}

final providers = (kReleaseMode) ? ProdProviders() : DevProviders();

class ItemsListNotifier extends StateNotifier<List<ItemModel>> {
  ItemsListNotifier({List<ItemModel> values = const []}) : super(values);

  void addItem({required final ItemModel item}) {
    state = [...state, item];
  }
}

enum ItemViewState {
  add,
  edit,
  view,
}

final searchQueryProvider = Provider<String>((ref) => '');

final searchResultsProvider = Provider<List<ItemModel>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final items = ref.watch(providers.itemsProvider);

  // Perform search logic here and return the filtered list of items
  return [];
});
