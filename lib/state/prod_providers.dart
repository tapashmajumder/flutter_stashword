import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProdProviders implements IProviders {
  final ItemsListNotifier _itemsListNotifier = ItemsListNotifier();

  @override
  StateNotifierProvider<ItemsListNotifier, List<ItemModel>> get itemsProvider =>
      StateNotifierProvider<ItemsListNotifier, List<ItemModel>>((ref) => _itemsListNotifier);

  @override
  final itemViewStateProvider = StateProvider<ItemViewState>((ref) => ItemViewState.view);

  @override
  final selectedItemProvider = Provider<ItemModel?>((ref) => null);
}
