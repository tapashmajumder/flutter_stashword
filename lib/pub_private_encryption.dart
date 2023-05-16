import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

void main() {
  AceRSAHelper.main();
}

class AceRSAHelper {
  static void main() {
    final pair = generateKeyPair();
    final encrypted = encrypt(
        "🙏zee-messageadfasdfa#@#\$@#%", pair.publicKey as RSAPublicKey);
    final decrypted = decrypt(encrypted, pair.privateKey as RSAPrivateKey);

    print("encrypted: $encrypted");
    print("decrypted: $decrypted");
  }

  // returns a base64 encoded string
  static String encrypt(String message, RSAPublicKey publicKey) {
    final cipher = RSAEngine()
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
    final cipherText = cipher.process(Uint8List.fromList(utf8.encode(message)));
    return base64.encode(cipherText);
  }

  static String decrypt(String base64EncodedCipher, RSAPrivateKey privateKey) {
    final cipher = RSAEngine()
      ..init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    final decrypted = cipher.process(base64.decode(base64EncodedCipher));
    return utf8.decode(decrypted);
  }

  static AsymmetricKeyPair<PublicKey, PrivateKey> generateKeyPair(
      {int keySize = 2048}) {
    final keyParams = RSAKeyGeneratorParameters(
      BigInt.parse('65537'), // public exponent
      keySize, // key size in bits
      12, // certainty
    );

    var secureRandom = _getSecureRandom();

    var rngParams = ParametersWithRandom(keyParams, secureRandom);
    var generator = RSAKeyGenerator();
    generator.init(rngParams);

    return generator.generateKeyPair();
  }

  static SecureRandom _getSecureRandom() {
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255 + 1));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }
}
