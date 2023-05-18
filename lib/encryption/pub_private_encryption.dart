import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/asn1/asn1_object.dart';
import 'package:pointycastle/asn1/asn1_parser.dart';
import 'package:pointycastle/asn1/primitives/asn1_bit_string.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_object_identifier.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class AceKeyPair {
  final String publicKey;
  final String privateKey;

  const AceKeyPair(this.publicKey, this.privateKey);
}

class AceRSAHelper {
  static AceKeyPair generateKeyPair() {
    final rsaKeyPair = _generateKeyPair();
    return AceKeyPair(_publicKeyToPem(rsaKeyPair.publicKey as RSAPublicKey), _privateKeyToPem(rsaKeyPair.privateKey as RSAPrivateKey));
  }

  static String encryptWithPublicKey(String message, String pemPublicKey) {
    final key = _pemToPublicKey(pemPublicKey);
    return _encrypt(message, key);
  }

  static String decryptWithPrivateKey(String encrypted, String pemPrivateKey) {
    final key = _pemToPrivateKey(pemPrivateKey);
    return _decrypt(encrypted, key);
  }

  // returns a base64 encoded string
  static String _encrypt(String message, RSAPublicKey publicKey) {
    final cipher = RSAEngine()
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
    final cipherText = cipher.process(Uint8List.fromList(utf8.encode(message)));
    return base64.encode(cipherText);
  }

  static String _decrypt(String base64EncodedCipher, RSAPrivateKey privateKey) {
    final cipher = RSAEngine()
      ..init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    final decrypted = cipher.process(base64.decode(base64EncodedCipher));
    return utf8.decode(decrypted);
  }

  static AsymmetricKeyPair<PublicKey, PrivateKey> _generateKeyPair(
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

  static String _publicKeyToPem(RSAPublicKey publicKey) {
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

  static String _privateKeyToPem(RSAPrivateKey rsaPrivateKey) {
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

  static RSAPublicKey _pemToPublicKey(String encoded) {
    return _publicKeyFromDERBytes(_getBytesFromPEMString(encoded));
  }

  static RSAPrivateKey _pemToPrivateKey(String pem) {
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
