import 'package:Stashword/encryption/aes_encryption.dart';
import 'package:test/test.dart';

void main() {
  void doEncryptDecrypt({required String? value, required String password, required String salt, required String iv, required String? expectedEncrypted}) {
    final derivedKey = AceAesHelper.generateEncryptionKey(password, salt, 1011);
    final String? encrypted;
    if (value == null) {
      encrypted = null;
    } else {
      encrypted = AceAesHelper.encrypt(value, derivedKey, iv);
    }

    expect(encrypted, equals(expectedEncrypted));

    final String? decrypted;
    if (encrypted == null) {
      decrypted = null;
    } else {
      decrypted = AceAesHelper.decrypt(encrypted, derivedKey, iv);
    }
    expect(value, equals(decrypted));
  }

  test('AES encryption and decryption', () {
    doEncryptDecrypt(value: null, password: "password", salt: "NH/u5kzCXNwrdYBCb5QU2Phm80MJAQyucxTbkGM8Gc8=", iv: "jfz8GObGqFItl07kqj/peA==", expectedEncrypted: null);
    doEncryptDecrypt(value: "password", password: "key1", salt: "NH/u5kzCXNwrdYBCb5QU2Phm80MJAQyucxTbkGM8Gc8=", iv: "jfz8GObGqFItl07kqj/peA==", expectedEncrypted: "ZJ/za/5BH9XEbnCAr2QBcQ==");
    doEncryptDecrypt(value: "Ax!@#\$%^&*()-+~", password: "!@#\$%^", salt: "NH/u5kzCXNwrdYBCb5QU2Phm80MJAQyucxTbkGM8Gc8=", iv: "jfz8GObGqFItl07kqj/peA==", expectedEncrypted: "4lqN0rpTeKjeuyVJvw8HDQ==");
    doEncryptDecrypt(value: "I rock very much?!", password: "!this-is-a-long-stashword!", salt: "NH/u5kzCXNwrdYBCb5QU2Phm80MJAQyucxTbkGM8Gc8=", iv: "jfz8GObGqFItl07kqj/peA==", expectedEncrypted: "aOce6Z1CnOomG1EaSE/8DnE1Grrs4rbT2o9iWh7KRgs=");
    doEncryptDecrypt(value: "f3d70b7ff93e4178acd4018a41141295", password: "key1", salt: "NH/u5kzCXNwrdYBCb5QU2Phm80MJAQyucxTbkGM8Gc8=", iv: "jfz8GObGqFItl07kqj/peA==", expectedEncrypted: "AqQozJM+WXZG/xG0AZvGVKoaxg89Cc3QM+/C6GuP734ZucfSfHP3IyesVeGiWFMt");
  });
}
