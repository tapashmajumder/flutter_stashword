import 'dart:io';
import 'dart:typed_data';

import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/network/network_operation.dart';
import 'package:Stashword/network/server_jsons.dart';
import 'package:Stashword/sync/sync_server_jsons.dart';

Future<void> withReturnType() async {
  final jsonOperation = NetworkOperation(
    requestMethod: RequestMethod.post,
    server: "api2.stashword.com",
    path: "/app/csc",
  );
  jsonOperation.headers = {
    HeaderParam.login: "tapash.majumder+1@gmail.com",
    HeaderParam.securityCode: "123",
  };

  SyncConfirmCodeResult result = await jsonOperation.fetchResult(fromJson: SyncConfirmCodeResult.fromJson);
  print(result);
}

Future<void> withoutReturnType() async {
  final jsonOperation = NetworkOperation(
    requestMethod: RequestMethod.post,
    server: "api2.stashword.com",
    path: "/app/updateItem",
  );
  jsonOperation.headers = {
    HeaderParam.login: "tapash.majumder+3@gmail.com",
    HeaderParam.token: "5a882dee04084a3ab4d4f5772ec5a288",
    HeaderParam.encryptedSanity: "zcjlsWuXyqjm7QmNNa9qVPt6njvwGFZImGda3KEbPn4=",
  };
  final itemJson = ItemJson(
    itemType: ItemType.password,
    id: "1a23a8634f1640319ccd30841a4e316a",
    iv: "QzoBSlvF29T9eKxNjvWGhw==",
    shared: true,
    sharedSecret: "wxZVajDLmR2Gkb3xffGJTdGUlg9zn1zsqausf6aga0mmC3OSPhkmGz2wrcjO5k1x",
    rgbInt: 10065516,
  );
  final value = await jsonOperation.sendRequest(jsonBody: itemJson.toJson());
  print(value);
}

Future<void> uploadBytes() async {
  const id = "stashword-email.jpg";
  final jsonOperation = NetworkOperation(requestMethod: RequestMethod.post, server: "files.stashword.com", path: "/data/store", queryParams: {
    QueryParam.id: id,
  });
  jsonOperation.headers = {
    HeaderParam.login: "tapash.majumder+3@gmail.com",
    HeaderParam.token: "5a882dee04084a3ab4d4f5772ec5a288",
    HeaderParam.encryptedSanity: "zcjlsWuXyqjm7QmNNa9qVPt6njvwGFZImGda3KEbPn4=",
  };
  final bytes = readBytes(path: "/Users/tapash/Downloads/$id");
  print("read: ${bytes.length} bytes");
  final value = await jsonOperation.uploadData(data: bytes);
  print(value);
}

Future<void> downloadBytes() async {
  const id = "stashword-email.jpg";
  final jsonOperation = NetworkOperation(requestMethod: RequestMethod.get, server: "files.stashword.com", path: "/data/find", queryParams: {
    QueryParam.id: id,
  });
  jsonOperation.headers = {
    HeaderParam.login: "tapash.majumder+3@gmail.com",
    HeaderParam.token: "5a882dee04084a3ab4d4f5772ec5a288",
    HeaderParam.encryptedSanity: "zcjlsWuXyqjm7QmNNa9qVPt6njvwGFZImGda3KEbPn4=",
  };
  final bytes = await jsonOperation.downloadData();
  File file = File("/Users/tapash/Downloads/downloaded-$id");
  file.writeAsBytesSync(bytes, flush: true);
}

Uint8List readBytes({required String path}) {
  File file = File(path);
  return file.readAsBytesSync();
}

Future<void> main() async {
//  await withReturnType();
  await withoutReturnType();
//   await uploadBytes();
//  await downloadBytes();
}

