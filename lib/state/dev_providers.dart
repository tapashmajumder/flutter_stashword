import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/util/ace_util.dart';
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
    ), ..._create1000values(),
  ]);

  @override
  StateNotifierProvider<ItemsListNotifier, List<ItemModel>> get itemsProvider =>
      StateNotifierProvider<ItemsListNotifier, List<ItemModel>>((ref) => _itemsListNotifier);

  @override
  final addItemStateProvider = StateProvider<AddItemState>((ref) => AddItemState.none);

  @override
  final selectedItemProvider = Provider<ItemModel?>((ref) => null);

  static List<ItemModel> _create1000values() {
    final List<ItemModel> list = [];
    for (var i = 0; i < 1000; ++i) {
      list.add(PasswordModel(
        id: AceUtil.newUuid(),
        iv: AceUtil.newIv(),
        name: "Item $i",
        userName: "userName$i",
        password: "password$i",
        sharedItem: AceUtil.nextRandom(max: 1) == 0 ? false : true,
      ));
    }
    return list;
  }
}
