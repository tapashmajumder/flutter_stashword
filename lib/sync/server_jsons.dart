import 'package:Stashword/model/item_models.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:Stashword/util/ace_util.dart';

part 'server_jsons.g.dart';

@JsonSerializable(includeIfNull: false)
class ItemJson {
  ItemType itemType;
  String id;
  String iv;
  String? blob;
  bool addToWatch;
  int? colorIndex;
  @JsonKey(
    toJson: AceUtil.dateTimeToMilliseconds,
    fromJson: AceUtil.millisecondsToDateTime,
  )
  DateTime? created;
  @JsonKey(
    toJson: AceUtil.dateTimeToMilliseconds,
    fromJson: AceUtil.millisecondsToDateTime,
  )
  DateTime? lastUsed;
  @JsonKey(
    toJson: AceUtil.dateTimeToMilliseconds,
    fromJson: AceUtil.millisecondsToDateTime,
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

  factory ItemJson.fromJson(Map<String, dynamic> json) =>
      _$ItemJsonFromJson(json);

  Map<String, dynamic> toJson() => _$ItemJsonToJson(this);
}
