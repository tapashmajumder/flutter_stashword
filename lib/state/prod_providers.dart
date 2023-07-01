import 'package:Stashword/data/data_service.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/state/providers.dart';
import 'package:Stashword/storage/ace_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProdProviders implements IProviders {
  final ItemsListNotifier _itemsListNotifier = ProdItemsListNotifier();

  @override
  StateNotifierProvider<ItemsListNotifier, List<ItemModel>> get itemsProvider =>
      StateNotifierProvider<ItemsListNotifier, List<ItemModel>>((ref) => _itemsListNotifier);

  @override
  final selectedItemProvider = StateProvider<ItemModel?>((ref) => null);

  @override
  final displayTypeProvider = StateProvider<DisplayType>((ref) => DisplayType.mobile);

  @override
  final showDialogProvider = StateProvider<DialogType>((ref) => DialogType.none);
}

class ProdItemsListNotifier extends ItemsListNotifier {
  final IAceStorage _storage = AceStorage(const DataService());

  ProdItemsListNotifier()  : super() {
    _init();
  }

  void _init() async {
    await _storage.init();
    state = _storage.findAllItems()..sort();
  }

  @override
  Future<void> addItem({required final ItemModel item}) async {
    await _storage.add(itemModel: item);
    super.addItem(item: item);
  }

  @override
  void updateItem({required ItemModel updatedItem}) async {
    await _storage.update(itemModel: updatedItem);
    super.updateItem(updatedItem: updatedItem);
  }

  @override
  void removeItem({required final ItemModel item}) async {
    await _storage.delete(itemModel: item);
    super.removeItem(item: item);
  }
}
