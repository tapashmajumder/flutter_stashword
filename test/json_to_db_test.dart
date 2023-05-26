import 'dart:convert';

import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/item_delete_info.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/storage/blob_serialization.dart';
import 'package:Stashword/sync/json_to_db_converter.dart';
import 'package:Stashword/sync/server_jsons.dart';
import 'package:test/test.dart';

void main() {
  String createPasswordBlob({
    String? name,
    List<String> photoIds = const [],
    List<String> categories = const [],
    List<CustomFieldInfo> customFields = const [],
    String? notes,
    String? url,
    String? userName,
    String? password,
    String? otpToken,
  }) {
    final PasswordBlob blob = PasswordBlob();
    blob.name = name;
    blob.notes = notes;
    blob.photoIds = photoIds;
    blob.tags = categories;
    blob.customFields = customFields;
    blob.url = url;
    blob.userName = userName;
    blob.password = password;
    blob.otpToken = otpToken;

    return json.encode(blob);
  }

  String createPasswordJsonFromServer({
    required String id,
    required String iv,
    String? name,
    bool addToWatch = false,
    int? colorIndex,
    DateTime? created,
    DateTime? lastUsed,
    DateTime? modified,
    bool shared = false,
    String? sharedSecret,
    List<String> photoIds = const [],
    List<String> categories = const [],
    List<CustomFieldInfo> customFields = const [],
    String? notes,
    String? url,
    String? userName,
    String? password,
    String? otpToken,
  }) {
    final blob = createPasswordBlob(
      name: name,
      notes: notes,
      photoIds: photoIds,
      categories: categories,
      customFields: customFields,
      url: url,
      userName: userName,
      password: password,
      otpToken: otpToken,
    );

    final itemJson = ItemJson(itemType: ItemType.password, id: id, iv: iv);
    itemJson.blob = blob;
    itemJson.addToWatch = addToWatch;
    itemJson.colorIndex = colorIndex;
    itemJson.created = created;
    itemJson.lastUsed = lastUsed;
    itemJson.modified = modified;
    itemJson.shared = shared;
    itemJson.sharedSecret = sharedSecret;

    return json.encode(itemJson);
  }

  test("create item json from server", () {
    const id = "id1";
    const iv = "iv1";
    const name = "zee-name";
    const addToWatch = true;
    const colorIndex = 23;
    final created = DateTime.timestamp();
    final lastUsed = DateTime.timestamp();
    final modified = DateTime.timestamp();
    const shared = true;
    const sharedSecret = "zee-shared-secret";
    final photoIds = ["1", "2", "3"];
    final categories = ["cat1", "cat2"];
    final customFields = [CustomFieldInfo("name", "value", FieldType.number)];
    const notes = "this is some random notes";
    const url = "zee-url";
    const userName = "zee-user-name";
    const password = "zee-password";
    const otpToken = "zee-otp-token";

    final String passwordBlob = createPasswordBlob(
      name: name,
      notes: notes,
      photoIds: photoIds,
      categories: categories,
      customFields: customFields,
      url: url,
      userName: userName,
      password: password,
      otpToken: otpToken,
    );

    String passwordJson = createPasswordJsonFromServer(
      id: id,
      iv: iv,
      name: name,
      addToWatch: addToWatch,
      colorIndex: colorIndex,
      created: created,
      lastUsed: lastUsed,
      modified: modified,
      shared: shared,
      sharedSecret: sharedSecret,
      photoIds: photoIds,
      categories: categories,
      customFields: customFields,
      notes: notes,
      url: url,
      userName: userName,
      password: password,
      otpToken: otpToken,
    );

    final decoded = ItemJson.fromJson(json.decode(passwordJson));

    expect(decoded.itemType, ItemType.password);
    expect(decoded.id, id);
    expect(decoded.iv, iv);
    expect(decoded.blob, passwordBlob);
    expect(decoded.addToWatch, addToWatch);
    expect(decoded.colorIndex, colorIndex);
    expect(decoded.created?.millisecondsSinceEpoch, created.millisecondsSinceEpoch);
    expect(decoded.lastUsed?.millisecondsSinceEpoch, lastUsed.millisecondsSinceEpoch);
    expect(decoded.modified?.millisecondsSinceEpoch, modified.millisecondsSinceEpoch);
    expect(decoded.shared, shared);
    expect(decoded.sharedSecret, sharedSecret);
  });

  test("ItemJson to Item conversion", () {
    const id = "id1";
    const iv = "iv1";
    const itemType = ItemType.doc;
    const addToWatch = true;
    const colorIndex = 23;
    final created = DateTime.timestamp();
    final lastUsed = DateTime.timestamp();
    final modified = DateTime.timestamp();
    const shared = true;
    const sharedSecret = "zee-shared-secret";
    const blob = "this is some blob";
    final itemJson = ItemJson(
      itemType: itemType,
      id: id,
      iv: iv,
      addToWatch: addToWatch,
      colorIndex: colorIndex,
      created: created,
      lastUsed: lastUsed,
      modified: modified,
      shared: shared,
      sharedSecret: sharedSecret,
    );
    itemJson.blob = blob;

    final item = JsonToDb.fromItemJsonToItem(itemJson);
    expect(item.itemType, itemType.value);
    expect(item.id, id);
    expect(item.iv, iv);
    expect(item.blob, blob);
    expect(item.addToWatch, addToWatch);
    expect(item.colorIndex, colorIndex);
    expect(item.created, created);
    expect(item.lastUsed, lastUsed);
    expect(item.modified, modified);
    expect(item.shared, shared);
    expect(item.sharedSecret, sharedSecret);
  });

  test("Item to ItemJson conversion", () {
    const id = "id1";
    const iv = "iv1";
    const itemType = ItemType.doc;
    const addToWatch = true;
    const colorIndex = 23;
    final created = DateTime.timestamp();
    final lastUsed = DateTime.timestamp();
    final modified = DateTime.timestamp();
    const shared = true;
    const sharedSecret = "zee-shared-secret";
    const blob = "this is some blob";
    final item = Item(
      itemType: itemType.value,
      id: id,
      iv: iv,
      addToWatch: addToWatch,
      colorIndex: colorIndex,
      created: created,
      lastUsed: lastUsed,
      modified: modified,
      shared: shared,
      sharedSecret: sharedSecret,
    );
    item.blob = blob;

    final itemJson = JsonToDb.fromItemToItemJson(item);
    expect(itemJson.itemType, itemType);
    expect(itemJson.id, id);
    expect(itemJson.iv, iv);
    expect(itemJson.blob, blob);
    expect(itemJson.addToWatch, addToWatch);
    expect(itemJson.colorIndex, colorIndex);
    expect(itemJson.created, created);
    expect(itemJson.lastUsed, lastUsed);
    expect(itemJson.modified, modified);
    expect(itemJson.shared, shared);
    expect(itemJson.sharedSecret, sharedSecret);
  });

  test("ItemDeleteInfoJson to ItemDeleteInfo conversion", () {
    const id = "id1";
    final deleteDate = DateTime.timestamp();
    final json = ItemDeleteInfoJson(
      id: id,
      deleteDate: deleteDate,
    );

    final itemDeleteInfo = JsonToDb.fromItemDeleteInfoJsonToItemDeleteInfo(json);
    expect(itemDeleteInfo.id, id);
    expect(itemDeleteInfo.deleteDate, deleteDate);
  });

  test("ItemDeleteInfo to ItemDeleteInfoJson conversion", () {
    const id = "id1";
    final deleteDate = DateTime.timestamp();
    final itemDeleteInfo = ItemDeleteInfo(
      id: id,
      deleteDate: deleteDate,
    );

    final json = JsonToDb.fromItemDeleteInfoToItemDeleteInfoJson(itemDeleteInfo);
    expect(json.id, id);
    expect(json.deleteDate, deleteDate);
  });

  test("create ItemDeleteInfo json from server", () {
    const id = "id1";
    final deleteDate = DateTime.timestamp();
    final itemDeleteInfoJson = ItemDeleteInfoJson(
      id: id,
      deleteDate: deleteDate,
    );

    String encoded = jsonEncode(itemDeleteInfoJson);
    final decoded = ItemDeleteInfoJson.fromJson(jsonDecode(encoded));

    expect(decoded.id, id);
    expect(decoded.deleteDate.millisecondsSinceEpoch, deleteDate.millisecondsSinceEpoch);
  });
}
