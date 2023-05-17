import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_bit_string.dart';
import 'package:pointycastle/asn1/primitives/asn1_object_identifier.dart';
import 'package:pointycastle/asn1/primitives/asn1_octet_string.dart';
import 'package:pointycastle/asn1/asn1_parser.dart';
import 'package:pointycastle/asn1/asn1_object.dart';

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

    const fromSwift =
        "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzu3pO5u6NKftcarhTApR\r\nqmDJ+Q81ELvo66J3Yb7mI8VtFD68z1nLttfhD0EIdI0i2Jd1n3djI3MguXSC6Um0\r\nsdmda9YF6jwEUexWx+vPs7qgDiR3NawJmcWxdahvwKSC3NKT67Io9PEiw4WOLnMH\r\nhCxH36yOH7bHa+w8rc3fWBRAIqYm9KwEt7iCxJrd/lWaTFU/knk8QPg9E+pjPuee\r\nibXyZW09KLALbaiU9Lnde4VW6/GCZd68U5L+Oxqz/hinKuK3vWE/EX43hT3hJWCL\r\n3OxPtaXfxV02nj2IgPYjYnK+vsgj+ubA7FUnlV5dV3lZP8r9zPck69GV84efoDxs\r\n8wIDAQAB";
    final pk = pemToPublicKey(fromSwift);
    final pkString = publicKeyToPem(pk);
    print("pkString: $pkString");
    print("fromSwift: $fromSwift");

    // neew one (for tapash.majumder+3@gmail.com)
    // "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw6KWyj9lzedkhqbFYSFR\r\n+wQJMSbGrhpxCXrAzmH9Ta/TZfx7+PvbDTj9I+E4jnlhMct5IwGbrqs/3Te7Ow5U\r\nRdFDBbvseZG2WxObcH3JOEeeEEWJNa/dW+HH3S5WUeHGcpT90wShrEQq7dLrWX/B\r\ny8v9J2IFQbgqdrjgYEJwHVUYgHjV0LC/ySyXmZBotqGAJi97vEukZvdTHyKJNuvL\r\nfK4u38taL2GR0TU/4dqweNCaecWpqfYsDuZZgqLqrbGZA2qIJVfO81gtTly5APUb\r\naOLE4NZykEG8N13g46kT+Ae4MHc+nKc4Oa5s33fg9BcSD/4ZoAVYYiyxxcPqQXpB\r\n5QIDAQAB"

    // private key
    const privateKeyFromSwift = "MIIEowIBAAKCAQEAznuYxIOq5laGJ/6c7CennHfxOmFuMGXGUrUkS8Te++ld7QUL\r\niBPTYTT9E5eSf8Up5t5mfAZzDiWy5LZI4Uw5t/Eyd8SUKkD2//mENRdYH36Alrqw\r\nnAROutluQgHXsJtLZw0Dm1yO2OdPYPW5/13VpQESbhJqQUDCkl8R0EgaaS58x7IT\r\n7UdN80NjOV/4qkrosJ9zbo1GK0jPi5EVgRG3ufMJJ3tsxDh0Og1Il5wiU70Yldsd\r\nJQTCjfLvWTBdOStx0QAO6USbv0h5mGYF3hwUFold0pngJgbNc42+8/6zYg+LfrNg\r\n8gLZ5eCz4hT8eTjuW5oFbcVhHYPEPqCDsg9MkwIDAQABAoIBADYqzV5MLkKj0yjd\r\nzfvTwVA2VOWcVqRCpr7ev0lTOa37QAUkTCykCtFW7cc8fZWgOwhSMq95n6hH8oC2\r\nYzMbZI7hKvypaLcW+NUY93pYB+mnLYOdMSSUqrSwwpB1XEh7zNGZY+dXZi/3qmbE\r\nv8kCrD/Poq6WjSJWI1TztMAfkjIiI15nPc1fJvln3b4sVT9utQVv8hvNxz6i8CZl\r\nKJ7qVlEOBoBO7rn2Ll+oMWtiVTOlQZi98qPxJbrmhiklIWIFfgVRKKptympq2Ol5\r\nkbw9VWbdvlWH8Juo0qL6Lx/1I/GFEeNOY7yHbVhdeI9dIkIYWamw2elUIMPJ9dBF\r\nmCNLTSUCgYEA+OvTbqdEbd3bB8aG7vqcT6X7iFjCaMhjJaoJZD+nCKxsyQ3lH6Fx\r\nRJtF31k2wISY4uIwPB6hJhyD94jqprrvbunMjDEEHeuiEK2H7OG+e8Sag3/RkBBe\r\ndvcE5bpuIWPvlw9m6laHFITGtT7RBppsmk5TbbuqJrqYOVLLjoJrHU8CgYEA1FrQ\r\niLhFn30v9zylc62kikiAj5Dvqkycd2unjqZKhmG+7d0gWvw+WtdrmrcfQ0UHI/XN\r\nPWudri03taORS5Bwh0t779djVFjS/mFwSV3wra1VnVnu4kSOKfPrZdxe0Ox8tvwU\r\n3rxfn3jPO2ZU8sb1ElGCi+Zmc7jwADFuGt4Q830CgYAKq0j3sDGtp9mwfqDf81vp\r\nygp68Jr8lMIzJhOa+WN2arWK9I6CiY/qSeF3zkIbhFNtPhalLQbpNEWvwW2VUePb\r\nVCgRRjSP976NinKOA6r/cRDSXBMmYp056iKKmjAIPFlTlzRpDOZjScGemR+qccn/\r\n3yWSSX3khRDrPBI/fHWM3wKBgQCNPCleBVEpFlYEle1k1qSM5FO9KKR+G54lPxCe\r\nK7N9VR1rjpqqaQH/4S7MI+dDEnIBVMZAh4bEBYb74+IK4/IzydyQVCzYOIt8bMoF\r\nwdkFajd7BAmBrB7xgC2b/cmCIwd/nIE08wyWP/90fkcZgYIVwOiWq5KQfPwC5N1a\r\nOUAE8QKBgAHC363/ozwt3AuEkhHBaCsDOHDVKN+6uXPoN1E2UMkAQ4UYdyS0vmDa\r\nhBp9kg8mM+Sdli90B+XdH6zDjRbR/W2TN6wkMps95B3OeHcAxl52zp9Xvq2opBfc\r\nTSorAWIrZbm/79FE9Pws7UAf1t7x5EvN7fl/MNEw90V/ZPJBa5eh";
    final privateKey = pemToPrivateKey(privateKeyFromSwift);
    final privateKeyString = privateKeyToPem(privateKey);
    print("privateKeyString: $privateKeyString");
    print("privateKeyFromSwift: $privateKeyFromSwift");
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

    final generator = RSAKeyGenerator()
      ..init(ParametersWithRandom(keyParams, _getSecureRandom()));

    return generator.generateKeyPair();
  }

  static String publicKeyToPem(RSAPublicKey publicKey) {
    final algorithmSeq = ASN1Sequence();
    final paramsAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
    algorithmSeq.add(ASN1ObjectIdentifier.fromName('rsaEncryption'));
    algorithmSeq.add(paramsAsn1Obj);

    final publicKeySeq = ASN1Sequence();
    publicKeySeq.add(ASN1Integer(publicKey.modulus));
    publicKeySeq.add(ASN1Integer(publicKey.exponent));
    final publicKeySeqBitString =
        ASN1BitString(stringValues: Uint8List.fromList(publicKeySeq.encode()));

    final topLevelSeq = ASN1Sequence();
    topLevelSeq.add(algorithmSeq);
    topLevelSeq.add(publicKeySeqBitString);
    return base64.encode(topLevelSeq.encode());
  }

  static String privateKeyToPem(RSAPrivateKey rsaPrivateKey) {
    final version = ASN1Integer(BigInt.from(0));
    final modulus = ASN1Integer(rsaPrivateKey.n);
    final publicExponent = ASN1Integer(BigInt.parse('65537'));
    final privateExponent = ASN1Integer(rsaPrivateKey.privateExponent);

    final p = ASN1Integer(rsaPrivateKey.p);
    final q = ASN1Integer(rsaPrivateKey.q);
    final dP =
        rsaPrivateKey.privateExponent! % (rsaPrivateKey.p! - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ =
        rsaPrivateKey.privateExponent! % (rsaPrivateKey.q! - BigInt.from(1));
    final exp2 = ASN1Integer(dQ);
    final iQ = rsaPrivateKey.q!.modInverse(rsaPrivateKey.p!);
    final co = ASN1Integer(iQ);

    final topLevelSeq = ASN1Sequence();
    topLevelSeq.add(version);
    topLevelSeq.add(modulus);
    topLevelSeq.add(publicExponent);
    topLevelSeq.add(privateExponent);
    topLevelSeq.add(p);
    topLevelSeq.add(q);
    topLevelSeq.add(exp1);
    topLevelSeq.add(exp2);
    topLevelSeq.add(co);
    return base64.encode(topLevelSeq.encode());
  }

  static RSAPublicKey pemToPublicKey(String encoded) {
    return _publicKeyFromDERBytes(_getBytesFromPEMString(encoded));
  }

  static RSAPrivateKey pemToPrivateKey(String pem) {
    final bytes = _getBytesFromPEMString(pem);
    return _privateKeyFromDERBytes(bytes);
  }

  static Uint8List _getBytesFromPEMString(String pem) {
    final lines = LineSplitter.split(pem)
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    final int startIndex;
    final int endIndex;
    if (lines.isNotEmpty && lines.first.startsWith('-----BEGIN')) {
      startIndex = 1;
    } else {
      startIndex = 0;
    }
    if (lines.length > 1 && lines.last.startsWith('-----END')) {
      endIndex = lines.length - 1;
    } else {
      endIndex = lines.length;
    }
    final base64 = lines.sublist(startIndex, endIndex).join('');
    return Uint8List.fromList(base64Decode(base64));
  }

  static RSAPublicKey _publicKeyFromDERBytes(Uint8List bytes) {
    final asn1Parser = ASN1Parser(bytes);
    final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
    final ASN1Sequence publicKeySeq;
    if (topLevelSeq.elements![1].runtimeType == ASN1BitString) {
      final publicKeyBitString = topLevelSeq.elements![1] as ASN1BitString;

      final publicKeyAsn =
          ASN1Parser(publicKeyBitString.stringValues as Uint8List?);
      publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;
    } else {
      publicKeySeq = topLevelSeq;
    }
    final modulus = publicKeySeq.elements![0] as ASN1Integer;
    final exponent = publicKeySeq.elements![1] as ASN1Integer;

    final rsaPublicKey = RSAPublicKey(modulus.integer!, exponent.integer!);

    return rsaPublicKey;
  }

  static RSAPrivateKey _privateKeyFromDERBytes(Uint8List bytes) {
    final asn1Parser = ASN1Parser(bytes);
    final pkSeq = asn1Parser.nextObject() as ASN1Sequence;

    final modulus = pkSeq.elements![1] as ASN1Integer;
    // ASN1Integer publicExponent = pkSeq.elements[2] as ASN1Integer;
    final privateExponent = pkSeq.elements![3] as ASN1Integer;
    final p = pkSeq.elements![4] as ASN1Integer;
    final q = pkSeq.elements![5] as ASN1Integer;
    // ASN1Integer exp1 = pkSeq.elements[6] as ASN1Integer;
    // ASN1Integer exp2 = pkSeq.elements[7] as ASN1Integer;
    // ASN1Integer co = pkSeq.elements[8] as ASN1Integer;

    final rsaPrivateKey = RSAPrivateKey(
        modulus.integer!, privateExponent.integer!, p.integer, q.integer);

    return rsaPrivateKey;
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
