import 'package:Stashword/model/item_models.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

enum ShareStatus {
  @JsonValue("None")
  none(value: "None"),
  @JsonValue("UserDoesNotExist")
  doesNotExist(value: "UserDoesNotExist"),
  @JsonValue("Pending")
  pending(value: "Pending"),
  @JsonValue("Declined")
  declined(value: "Declined"),
  @JsonValue("Accepted")
  accepted(value: "Accepted"),
  @JsonValue("DeletedBySharee")
  deletedBySharee(value: "DeletedBySharee"),
  @JsonValue("NeedToResend")
  needToResend(value: "NeedToResend");

  final String value;

  const ShareStatus({required this.value});
}

extension ShareStatusExtension on ShareStatus {
  static ShareStatus fromString({required String value}) {
    return ShareStatus.values.firstWhereOrNull((element) => element.value == value) ?? ShareStatus.none;
  }
}

class PendingShareInfoModel {
  ItemType itemType;
  String id;
  String iv;
  String? name;
  ShareStatus shareStatus;
  String sharer;
  String? sharedSecret;

  PendingShareInfoModel({
    required this.itemType,
    required this.id,
    required this.iv,
    this.name,
    required this.shareStatus,
    required this.sharer,
    this.sharedSecret,
  });
}
