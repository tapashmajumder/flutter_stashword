import 'package:Stashword/sync/server_jsons.dart';
import 'package:Stashword/util/ace_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sync_info.g.dart';

@JsonSerializable(includeIfNull: false)
class SyncInfo {
  List<ItemJson> createdItems = [];
  List<ItemJson> modifiedItems = [];
  List<ItemDeleteInfoJson> deletedItems = [];
  List<ItemJson> sharedItems = [];
  List<PendingShareInfoJson> pendingShares = [];
  @JsonKey(
    toJson: AceUtil.nullableDateTimeToMilliseconds,
    fromJson: AceUtil.nullableMillisecondsToDateTime,
  )
  DateTime? lastSyncDate;

  SyncInfo({
    this.createdItems = const [],
    this.modifiedItems = const [],
    this.deletedItems = const [],
    this.sharedItems = const [],
    this.pendingShares = const [],
    this.lastSyncDate,
  });
}
