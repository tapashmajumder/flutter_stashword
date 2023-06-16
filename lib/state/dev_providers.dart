import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DevProviders implements IProviders {
  DevProviders();

  final ItemsListNotifier _itemsListNotifier = ItemsListNotifier(values: [
    PasswordModel(
      id: "id1",
      iv: "iv1",
      name: "iCloud 1",
      userName: "user@example.com",
      shared: true,
    ),
    PasswordModel(
      id: "id2",
      iv: "iv2",
      name: "Amazon AWS",
      userName: "user@example.com",
      sharedItem: true,
    ),
  ]);

  @override
  StateNotifierProvider<ItemsListNotifier, List<ItemModel>> get itemsProvider =>
      StateNotifierProvider<ItemsListNotifier, List<ItemModel>>((ref) => _itemsListNotifier);

  @override
  final itemViewStateProvider = StateProvider<ItemViewState>((ref) => ItemViewState.add);

  @override
  final selectedItemProvider = Provider<ItemModel?>((ref) => null);
}
