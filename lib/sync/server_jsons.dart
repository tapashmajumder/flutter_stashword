import 'package:Stashword/model/item_models.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:Stashword/util/ace_util.dart';

part 'server_jsons.g.dart';

@JsonSerializable(includeIfNull: false)
class SyncInfo {
  @JsonKey(
    toJson: AceUtil.dateTimeToMillisecondsNullable,
    fromJson: AceUtil.millisecondsToDateTimeNullable,
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
    toJson: AceUtil.dateTimeToMillisecondsNullable,
    fromJson: AceUtil.millisecondsToDateTimeNullable,
  )
  DateTime? created;
  @JsonKey(
    toJson: AceUtil.dateTimeToMillisecondsNullable,
    fromJson: AceUtil.millisecondsToDateTimeNullable,
  )
  DateTime? lastUsed;
  @JsonKey(
    toJson: AceUtil.dateTimeToMillisecondsNullable,
    fromJson: AceUtil.millisecondsToDateTimeNullable,
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
