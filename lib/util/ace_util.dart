import 'package:dartz/dartz.dart';

final class AceUtil {
  static int? nullableDateTimeToMilliseconds(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;

  static DateTime? nullableMillisecondsToDateTime(int? milliseconds) => milliseconds != null ? DateTime.fromMillisecondsSinceEpoch(milliseconds) : null;

  static int dateTimeToMilliseconds(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  static DateTime millisecondsToDateTime(int milliseconds) => DateTime.fromMillisecondsSinceEpoch(milliseconds);
}

extension EitherExtension<L, R> on Either<L, R> {
  R? getRight() => fold<R?>((_) => null, (r) => r);
  L? getLeft() => fold<L?>((l) => l, (_) => null);
}