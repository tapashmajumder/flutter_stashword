import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';

import 'package:encrypt/encrypt.dart';

class AceAesHelper {
  static Uint8List generateEncryptionKey(String password, String base64EncodedSalt, int iterations) {
    const keyLength = 32; // 256-bit key
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
    final saltData = base64.decode(base64EncodedSalt);
    final params = Pbkdf2Parameters(saltData, iterations, keyLength);
    pbkdf2.init(params);

    final key = pbkdf2.process(Uint8List.fromList(utf8.encode(password)));
    return key;
  }

  static String encrypt(final String value, final Uint8List encryptionKey, final String base64IV) {
    final bytes = encryptData(Uint8List.fromList(utf8.encode(value)), encryptionKey, IV.fromBase64(base64IV));
    return base64.encode(bytes);
  }

  static String decrypt(final String encrypted, final Uint8List encryptionKey, final String base64IV) {
    final decryptedBytes = decryptData(base64.decode(encrypted), encryptionKey, IV.fromBase64(base64IV));
    return utf8.decode(decryptedBytes, allowMalformed: true);
  }

  static Uint8List encryptData(final Uint8List data, final Uint8List encryptionKey, final IV iv) {
    final key = Key(encryptionKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = encrypter.encryptBytes(data, iv: iv);
    return encrypted.bytes;
  }

  static Uint8List decryptData(final Uint8List encryptedData, final Uint8List encryptionKey, final IV iv) {
    final key = Key(encryptionKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = Encrypted(encryptedData);
    return Uint8List.fromList(encrypter.decryptBytes(encrypted, iv: iv));
  }

  static String generateRandomIV() {
    return IV.fromSecureRandom(16).base64;
  }
}