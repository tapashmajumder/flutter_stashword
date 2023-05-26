final class AceUtil {
  static int? dateTimeToMilliseconds(DateTime? dateTime) =>
      dateTime?.millisecondsSinceEpoch;

  static DateTime? millisecondsToDateTime(int?milliseconds) =>
      milliseconds != null
          ? DateTime.fromMillisecondsSinceEpoch(milliseconds)
          : null;
}