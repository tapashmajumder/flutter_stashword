final class AceUtil {
  static int? dateTimeToMillisecondsNullable(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;

  static DateTime? millisecondsToDateTimeNullable(int? milliseconds) => milliseconds != null ? DateTime.fromMillisecondsSinceEpoch(milliseconds) : null;

  static int dateTimeToMilliseconds(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  static DateTime millisecondsToDateTime(int milliseconds) => DateTime.fromMillisecondsSinceEpoch(milliseconds);
}
