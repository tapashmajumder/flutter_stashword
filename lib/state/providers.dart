import 'package:Stashword/model/item_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemsListNotifier extends StateNotifier<List<ItemModel>> {
  ItemsListNotifier() : super([
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
  ]);

  static final provider = StateNotifierProvider<ItemsListNotifier, List<ItemModel>>((ref) => ItemsListNotifier());

  void addItem({required final ItemModel item}) {
    state = [...state, item];
  }

  void addItem2() {
    final item = PasswordModel(
      id: "id2",
      iv: "iv2",
      name: "Amazon AWS",
      userName: "user@example.com",
      sharedItem: true,
    );

    state = [...state, item];
  }
}

final selectedItemProvider = Provider<ItemModel?>((ref) => null);

enum ItemViewState {
  add,
  edit,
  view,
}

final itemViewStateProvider = StateProvider<ItemViewState>((ref) => ItemViewState.view);

final searchQueryProvider = Provider<String>((ref) => '');

final searchResultsProvider = Provider<List<ItemModel>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final items = ref.watch(ItemsListNotifier.provider);

  // Perform search logic here and return the filtered list of items
  return [];
});
