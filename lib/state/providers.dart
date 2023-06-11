import 'package:Stashword/model/item_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final itemsProvider = Provider<List<ItemModel>>((ref) {
  return [
    PasswordModel(
      id: "id1",
      iv: "iv1",
      name: "iCloud",
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
  ];
});

final selectedItemProvider = Provider<ItemModel?>((ref) => null);

enum ItemViewState {
  add,
  edit,
  view,
}

final itemViewStateProvider = Provider<ItemViewState>((ref) => ItemViewState.view);

final searchQueryProvider = Provider<String>((ref) => '');

final searchResultsProvider = Provider<List<ItemModel>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final items = ref.watch(itemsProvider);

  // Perform search logic here and return the filtered list of items
  return [];
});
