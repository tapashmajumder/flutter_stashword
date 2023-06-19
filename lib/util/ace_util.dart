import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

final class AceUtil {
  static int? nullableDateTimeToMilliseconds(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;

  static DateTime? nullableMillisecondsToDateTime(int? milliseconds) => milliseconds != null ? DateTime.fromMillisecondsSinceEpoch(milliseconds) : null;

  static int dateTimeToMilliseconds(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  static DateTime millisecondsToDateTime(int milliseconds) => DateTime.fromMillisecondsSinceEpoch(milliseconds);

  static String newUuid() {
    return const Uuid().v4().replaceAll("-", "");
  }

  static String newIv() {
    return generateRandomString(bytes: 16);
  }

  static int nextRandom({required int max}) {
    final random = Random();
    return random.nextInt(max);
  }

  static String generateRandomString({required int bytes}) {
    return base64.encode(_randomBytes(n: bytes));
  }

  static Uint8List _randomBytes({required int n}) {
    final random = Random();
    final bytes = Uint8List(16);
    for (var i = 0; i < n; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes;
  }
}

extension EitherExtension<L, R> on Either<L, R> {
  R? getRight() => fold<R?>((_) => null, (r) => r);
  L? getLeft() => fold<L?>((l) => l, (_) => null);
}

extension StringExtension on String {
  String? nullIfEmpty() {
    return isEmpty ? null : this;
  }
}