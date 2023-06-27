import 'dart:typed_data';

import 'package:Stashword/data/data_service.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/storage/model_to_db_converters.dart';

class ImageData {
  String id;
  Uint8List data;

  ImageData(
    this.id,
    this.data,
  );
}

abstract interface class IAceStorage {
  Future<void> init();

  Future<void> close();

  List<ItemModel> findAllItems();

  Future<void> add({required ItemModel itemModel, List<ImageData> images = const []});

  Future<void> update({required ItemModel itemModel, List<ImageData> images = const []});

  Future<void> delete({required ItemModel itemModel});
}

class AceStorage implements IAceStorage {
  AceStorage(this._dataService);

  final IDataService _dataService;

  @override
  Future<void> init() async {
    await _dataService.init();
  }

  @override
  Future<void> close() async {
    await _dataService.close();
  }

  @override
  List<ItemModel> findAllItems() {
    return _dataService.findAllItems().map((item) => ModelToDbConverter.fromItemToModel(item: item)).toList();
  }

  @override
  Future<void> add({required ItemModel itemModel, List<ImageData> images = const []}) async {
    final item = ModelToDbConverter.fromModelToItem(model: itemModel);
    await _dataService.createItem(item: item);
  }

  @override
  Future<void> update({required ItemModel itemModel, List<ImageData> images = const []}) async {
    final item = ModelToDbConverter.fromModelToItem(model: itemModel);
    await _dataService.updateItem(item: item);
  }

  @override
  Future<void> delete({required ItemModel itemModel}) async {
    await _dataService.deleteItemById(id: itemModel.id);
  }
}
