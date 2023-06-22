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
  final addItemStateProvider = StateProvider<AddItemState>((ref) => AddItemState.none);

  @override
  final selectedItemProvider = Provider<ItemModel?>((ref) => null);
}

class ProdItemsListNotifier extends ItemsListNotifier {
  final IAceStorage _storage = AceStorage(const DataService());

  ProdItemsListNotifier()  : super() {
    _init();
  }

  void _init() async {
    await _storage.init();
    state = _storage.findAllItems();
  }

  @override
  Future<void> addItem({required final ItemModel item}) async {
    await _storage.add(itemModel: item);
    super.addItem(item: item);
  }
}
