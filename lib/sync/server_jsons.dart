import 'package:Stashword/model/item_models.dart';
import 'package:Stashword/model/pending_share_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:Stashword/util/ace_util.dart';

part 'server_jsons.g.dart';

@JsonSerializable(includeIfNull: false)
class SyncInfo {
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  DateTime? lastSyncDate;
  List<ItemJson> createdItems;
  List<ItemJson> modifiedItems;
  List<ItemDeleteInfoJson> deletedItems;

  SyncInfo({
    this.lastSyncDate,
    this.createdItems = const [],
    this.modifiedItems = const [],
    this.deletedItems = const [],
  });

  factory SyncInfo.fromJson(Map<String, dynamic> json) => _$SyncInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SyncInfoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ItemJson {
  ItemType itemType;
  String id;
  String iv;
  String? blob;
  bool addToWatch;
  int? colorIndex;
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  DateTime? created;
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  DateTime? lastUsed;
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  DateTime? modified;
  bool shared;
  String? sharedSecret;

  ItemJson({
    required this.itemType,
    required this.id,
    required this.iv,
    this.blob,
    this.addToWatch = false,
    this.colorIndex,
    this.created,
    this.lastUsed,
    this.modified,
    this.shared = false,
    this.sharedSecret,
  });

  factory ItemJson.fromJson(Map<String, dynamic> json) => _$ItemJsonFromJson(json);

  Map<String, dynamic> toJson() => _$ItemJsonToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ItemDeleteInfoJson {
  String id;
  @JsonKey(
    toJson: AceUtil.dateTimeToMilliseconds,
    fromJson: AceUtil.millisecondsToDateTime,
  )
  DateTime deleteDate;

  ItemDeleteInfoJson({
    required this.id,
    required this.deleteDate,
  });

  factory ItemDeleteInfoJson.fromJson(Map<String, dynamic> json) => _$ItemDeleteInfoJsonFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDeleteInfoJsonToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SharedItemJson {
  ItemType itemType;
  String id;
  String iv;
  String? blob;
  bool addToWatch;
  int? colorIndex;
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  DateTime? created;
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  DateTime? lastUsed;
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  DateTime? modified;
  String sharer;
  String sharedSecret;

  SharedItemJson({
    required this.itemType,
    required this.id,
    required this.iv,
    required this.sharer,
    required this.sharedSecret,
    this.blob,
    this.addToWatch = false,
    this.colorIndex,
    this.created,
    this.lastUsed,
    this.modified,
  });

  factory SharedItemJson.fromJson(Map<String, dynamic> json) => _$SharedItemJsonFromJson(json);

  Map<String, dynamic> toJson() => _$SharedItemJsonToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PendingShareInfoJson {
  ItemType itemType;
  String id;
  String iv;
  ShareStatus shareStatus;
  String sharer;
  String? sharedSecret;
  String? blob;

  PendingShareInfoJson({
    required this.itemType,
    required this.id,
    required this.iv,
    required this.shareStatus,
    required this.sharer,
    this.sharedSecret,
    this.blob,
  });

  factory PendingShareInfoJson.fromJson(Map<String, dynamic> json) => _$PendingShareInfoJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PendingShareInfoJsonToJson(this);
}
