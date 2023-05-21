import 'dart:typed_data';

import 'package:Stashword/data/database.dart';
import 'package:Stashword/model/item_models.dart';

class ImageData {
  String id;
  Uint8List data;

  ImageData(this.id,
      this.data,);
}

abstract interface class IAceStorage {
  Future<void> init({String? subdir, ISecureStorage secureStorage});

  Future<void> add(
      {required ItemModel item, List<ImageData> images = const []});
}

class AceStorage implements IAceStorage {
  @override
  Future<void> init(
      {String? subdir, ISecureStorage secureStorage = const ProdSecureStorage()}) async {
    if (subdir == null) {
      await Database.init();
    } else {
      await Database.init(subdir: subdir);
    }
    await Database.open(secureStorage: secureStorage);
  }

  @override
  Future<void> add(
      {required ItemModel item, List<ImageData> images = const []}) async {

  }
}

