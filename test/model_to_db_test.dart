import 'dart:convert';

import 'package:Stashword/data/item.dart';
import 'package:Stashword/data/pending_share_info.dart';
import 'package:Stashword/data/shared_item.dart';
import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/model/pending_share_info_model.dart';
import 'package:test/test.dart';

import 'package:Stashword/storage/model_to_db_converters.dart';

void main() {
  test('Password Model Serialization', () {
    const id = "id1";
    const iv = "iv1";
    const name = "zee-name";
    const notes = "zee-notes";
    const photoIds = ["id1", "id2"];
    const tags = ["category1", "category2"];
    final customFields = [
      CustomFieldInfo(name: "customFieldName", value: "CustomFieldValue", type: FieldType.email)
    ];
    const addToWatch = true;
    const colorIndex = 24;
    final created = DateTime.timestamp();
    final lastUsed = DateTime.timestamp();
    final modified = DateTime.timestamp();
    const shared = true;
    const sharedSecret = "zee-shared-secret";


    const url = "https://somewhere.com";
    const userName = "user@example.com";
    const password = "zee'user@#\$@\$#%ame";
    const otpToken = "zee-otp";

    final model = PasswordModel(
      id: id,
      iv: iv,
      name: name,
      notes: notes,
      photoIds: photoIds,
      tags: tags,
      customFields: customFields,
      addToWatch: addToWatch,
      colorIndex: colorIndex,
      created: created,
      lastUsed: lastUsed,
      modified: modified,
      shared: shared,
      sharedSecret: sharedSecret,
    );
    model.url = url;
    model.userName = userName;
    model.password = password;
    model.otpToken = otpToken;

    Item item = ModelToDbConverter.fromModelToItem(model: model);
    final PasswordModel newModel = ModelToDbConverter.fromItemToModel(item: item);

    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.name, equals(name));
    expect(newModel.notes, equals(notes));
    expect(newModel.photoIds, equals(photoIds));
    expect(newModel.tags, equals(tags));
    expect(newModel.customFields, equals(customFields));
    expect(newModel.addToWatch, equals(addToWatch));
    expect(newModel.colorIndex, equals(colorIndex));
    expect(newModel.created, equals(created));
    expect(newModel.modified, equals(modified));
    expect(newModel.lastUsed, equals(lastUsed));
    expect(newModel.shared, equals(shared));
    expect(newModel.sharedSecret, equals(sharedSecret));

    expect(newModel.itemType, equals(ItemType.password));
    expect(newModel.url, equals(url));
    expect(newModel.userName, equals(userName));
    expect(newModel.password, equals(password));
    expect(newModel.otpToken, equals(otpToken));
  });

  test('Shared Password Model Serialization', () {
    const id = "id1";
    const iv = "iv1";
    const name = "zee-name";
    const notes = "zee-notes";
    const photoIds = ["id1", "id2"];
    const tags = ["category1", "category2"];
    final customFields = [
      CustomFieldInfo(name: "customFieldName", value: "CustomFieldValue", type: FieldType.email)
    ];
    const addToWatch = true;
    const colorIndex = 24;
    final created = DateTime.timestamp();
    final lastUsed = DateTime.timestamp();
    final modified = DateTime.timestamp();
    const isSharedItem = true;
    const shared = true;
    const sharedSecret = "zee-shared-secret";


    const url = "https://somewhere.com";
    const userName = "user@example.com";
    const password = "zee'user@#\$@\$#%ame";
    const otpToken = "zee-otp";

    final model = PasswordModel(
      id: id,
      iv: iv,
      sharedItem: isSharedItem,
      name: name,
      notes: notes,
      photoIds: photoIds,
      tags: tags,
      customFields: customFields,
      addToWatch: addToWatch,
      colorIndex: colorIndex,
      created: created,
      lastUsed: lastUsed,
      modified: modified,
      shared: shared,
      sharedSecret: sharedSecret,
    );
    model.url = url;
    model.userName = userName;
    model.password = password;
    model.otpToken = otpToken;

    SharedItem sharedItem = ModelToDbConverter.fromModelToSharedItem(model: model);
    final PasswordModel newModel = ModelToDbConverter.fromSharedItemToModel(sharedItem: sharedItem);

    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.name, equals(name));
    expect(newModel.notes, equals(notes));
    expect(newModel.photoIds, equals(photoIds));
    expect(newModel.tags, equals(tags));
    expect(newModel.customFields, equals(customFields));
    expect(newModel.addToWatch, equals(addToWatch));
    expect(newModel.colorIndex, equals(colorIndex));
    expect(newModel.created, equals(created));
    expect(newModel.modified, equals(modified));
    expect(newModel.lastUsed, equals(lastUsed));
    expect(newModel.sharedItem, equals(isSharedItem));
    expect(newModel.shared, equals(shared));
    expect(newModel.sharedSecret, equals(sharedSecret));

    expect(newModel.itemType, equals(ItemType.password));
    expect(newModel.url, equals(url));
    expect(newModel.userName, equals(userName));
    expect(newModel.password, equals(password));
    expect(newModel.otpToken, equals(otpToken));
  });

  test('BankAccount Model Serialization', () {
    const id = "id1";
    const iv = "iv1";

    const accountNo = "account-no";
    const routingNo = "routing-no";
    const supportNo = "support-no";
    const pinNo = "pin-no";
    const swiftCode = "zee-swift-code";

    final model = BankAccountModel(
      id: id,
      iv: iv,
    );
    model.accountNo = accountNo;
    model.routingNo = routingNo;
    model.supportNo = supportNo;
    model.pinNo = pinNo;
    model.swiftCode = swiftCode;

    Item item = ModelToDbConverter.fromModelToItem(model: model);
    final BankAccountModel newModel = ModelToDbConverter.fromItemToModel(item: item);

    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.itemType, equals(ItemType.bankAccount));
    expect(newModel.accountNo, equals(accountNo));
    expect(newModel.routingNo, equals(routingNo));
    expect(newModel.supportNo, equals(supportNo));
    expect(newModel.pinNo, equals(pinNo));
  });

  test('FF Model Serialization', () {
    const id = "id1";
    const iv = "iv1";

    const ffNo = "ff-no";
    const supportNo = "support-no";

    final model = FFModel(
      id: id,
      iv: iv,
    );
    model.ffNo = ffNo;
    model.supportNo = supportNo;

    Item item = ModelToDbConverter.fromModelToItem(model: model);
    final FFModel newModel = ModelToDbConverter.fromItemToModel(item: item);

    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.itemType, equals(ItemType.ff));
    expect(newModel.ffNo, equals(ffNo));
    expect(newModel.supportNo, equals(supportNo));
  });

  test('Note Serialization', () {
    const id = "id1";
    const iv = "iv1";
    const notes = "this is some note";

    final model = NoteModel(
      id: id,
      iv: iv,
    );
    model.notes = notes;

    Item item = ModelToDbConverter.fromModelToItem(model: model);
    final NoteModel newModel = ModelToDbConverter.fromItemToModel(item: item);

    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.itemType, equals(ItemType.note));
    expect(newModel.notes, notes);
  });

  test('Code Serialization', () {
    const id = "id1";
    const iv = "iv1";
    const code = "this is some code";

    final model = CodeModel(
      id: id,
      iv: iv,
    );
    model.code = code;

    Item item = ModelToDbConverter.fromModelToItem(model: model);
    final CodeModel newModel = ModelToDbConverter.fromItemToModel(item: item);

    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.itemType, equals(ItemType.code));
    expect(newModel.code, code);
  });

  test('Card Serialization', () {
    const id = "id1";
    const iv = "iv1";

    const cardType = CardType.disc;
    const cardHolderName = "Tapash Majumder";
    const cardNumber = "123456781334";
    const verificationNumber = "34534";
    const expirationMonth = Month.september;
    const expirationYear = Year.y2029;
    const pinNumber = "1234";
    const supportNumber = "1-800-123-4567";

    final model = CardModel(
      id: id,
      iv: iv,
    );
    model.cardType = cardType;
    model.cardHolderName = cardHolderName;
    model.cardNumber = cardNumber;
    model.verificationNumber = verificationNumber;
    model.expirationMonth = expirationMonth;
    model.expirationYear = expirationYear;
    model.pinNumber = pinNumber;
    model.supportNumber = supportNumber;

    Item item = ModelToDbConverter.fromModelToItem(model: model);
    final CardModel newModel = ModelToDbConverter.fromItemToModel(item: item);

    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.itemType, equals(ItemType.card));

    expect(newModel.cardType, equals(cardType));
    expect(newModel.cardHolderName, equals(cardHolderName));
    expect(newModel.cardNumber, equals(cardNumber));
    expect(newModel.verificationNumber, equals(verificationNumber));
    expect(newModel.expirationMonth, equals(expirationMonth));
    expect(newModel.expirationYear, equals(expirationYear));
    expect(newModel.pinNumber, equals(pinNumber));
    expect(newModel.supportNumber, equals(supportNumber));
  });

  test('Doc Serialization', () {
    const id = "id1";
    const iv = "iv1";

    const docType = DocType.insurance;
    final List<DocField> fields = [
      DocField(fieldType: FieldType.email, label: "the email", placeHolder: "the email placeholder"),
      DocField(fieldType: FieldType.date, label: "the date", placeHolder: "the date placeholder"),
      DocField(fieldType: FieldType.number, label: "the number", placeHolder: "the number placeholder"),
    ];

    final model = DocModel(
      id: id,
      iv: iv,
    );
    model.docType = docType;
    model.fields = fields;

    Item item = ModelToDbConverter.fromModelToItem(model: model);
    final DocModel newModel = ModelToDbConverter.fromItemToModel(item: item);

    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.itemType, equals(ItemType.doc));

    expect(newModel.docType, equals(docType));
    expect(newModel.fields, equals(fields));
  });

  test('PendingShareInfo Serialization', () {
    const itemType = ItemType.card;
    const id = "id1";
    const iv = "iv1";
    const sharer = "user1@example.com";
    const shareStatus = ShareStatus.needToResend;
    const sharedSecret = "zee-shared-secret";
    const name = "zee-name";
    const blob = '{"name": "$name"}';

    final shareInfo = PendingShareInfo(
      itemType: itemType.value,
      id: id,
      iv: iv,
      sharer: sharer,
      shareStatus: shareStatus.value,
      sharedSecret: sharedSecret,
      blob: blob,
    );

    final PendingShareInfoModel newModel = ModelToDbConverter.fromPendingShareInfoToPendingShareInfoModel(shareInfo: shareInfo);

    expect(newModel.itemType, itemType);
    expect(newModel.id, equals(id));
    expect(newModel.iv, equals(iv));
    expect(newModel.sharer, equals(sharer));
    expect(newModel.shareStatus, equals(shareStatus));
    expect(newModel.sharedSecret, equals(sharedSecret));
    expect(newModel.name, equals(name));
  });
}
