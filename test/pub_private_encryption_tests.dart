import 'package:Stashword/pub_private_encryption.dart';
import 'package:test/test.dart';

void main() {
  void keyPairTests(final String message, final String pemPublicKey, final String pemPrivateKey) {
    final encrypted = AceRSAHelper.encryptWithPublicKey(message, pemPublicKey);
    final decrypted = AceRSAHelper.decryptWithPrivateKey(encrypted, pemPrivateKey);
    expect(encrypted, isNot(message));
    expect(decrypted, equals(message));
  }

  test('Key Generation', () {
    const message = "🙏zee-messageadfasdfa#@#\$@#%";
    final pair = AceRSAHelper.generateKeyPair();
    keyPairTests(message, pair.publicKey, pair.privateKey);
  });

  test('Test Key Pair Set 1', () {
    const pemPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAznuYxIOq5laGJ/6c7Cen\r\nnHfxOmFuMGXGUrUkS8Te++ld7QULiBPTYTT9E5eSf8Up5t5mfAZzDiWy5LZI4Uw5\r\nt/Eyd8SUKkD2//mENRdYH36AlrqwnAROutluQgHXsJtLZw0Dm1yO2OdPYPW5/13V\r\npQESbhJqQUDCkl8R0EgaaS58x7IT7UdN80NjOV/4qkrosJ9zbo1GK0jPi5EVgRG3\r\nufMJJ3tsxDh0Og1Il5wiU70YldsdJQTCjfLvWTBdOStx0QAO6USbv0h5mGYF3hwU\r\nFold0pngJgbNc42+8/6zYg+LfrNg8gLZ5eCz4hT8eTjuW5oFbcVhHYPEPqCDsg9M\r\nkwIDAQAB";
    const pemPrivateKey = "MIIEowIBAAKCAQEAznuYxIOq5laGJ/6c7CennHfxOmFuMGXGUrUkS8Te++ld7QUL\r\niBPTYTT9E5eSf8Up5t5mfAZzDiWy5LZI4Uw5t/Eyd8SUKkD2//mENRdYH36Alrqw\r\nnAROutluQgHXsJtLZw0Dm1yO2OdPYPW5/13VpQESbhJqQUDCkl8R0EgaaS58x7IT\r\n7UdN80NjOV/4qkrosJ9zbo1GK0jPi5EVgRG3ufMJJ3tsxDh0Og1Il5wiU70Yldsd\r\nJQTCjfLvWTBdOStx0QAO6USbv0h5mGYF3hwUFold0pngJgbNc42+8/6zYg+LfrNg\r\n8gLZ5eCz4hT8eTjuW5oFbcVhHYPEPqCDsg9MkwIDAQABAoIBADYqzV5MLkKj0yjd\r\nzfvTwVA2VOWcVqRCpr7ev0lTOa37QAUkTCykCtFW7cc8fZWgOwhSMq95n6hH8oC2\r\nYzMbZI7hKvypaLcW+NUY93pYB+mnLYOdMSSUqrSwwpB1XEh7zNGZY+dXZi/3qmbE\r\nv8kCrD/Poq6WjSJWI1TztMAfkjIiI15nPc1fJvln3b4sVT9utQVv8hvNxz6i8CZl\r\nKJ7qVlEOBoBO7rn2Ll+oMWtiVTOlQZi98qPxJbrmhiklIWIFfgVRKKptympq2Ol5\r\nkbw9VWbdvlWH8Juo0qL6Lx/1I/GFEeNOY7yHbVhdeI9dIkIYWamw2elUIMPJ9dBF\r\nmCNLTSUCgYEA+OvTbqdEbd3bB8aG7vqcT6X7iFjCaMhjJaoJZD+nCKxsyQ3lH6Fx\r\nRJtF31k2wISY4uIwPB6hJhyD94jqprrvbunMjDEEHeuiEK2H7OG+e8Sag3/RkBBe\r\ndvcE5bpuIWPvlw9m6laHFITGtT7RBppsmk5TbbuqJrqYOVLLjoJrHU8CgYEA1FrQ\r\niLhFn30v9zylc62kikiAj5Dvqkycd2unjqZKhmG+7d0gWvw+WtdrmrcfQ0UHI/XN\r\nPWudri03taORS5Bwh0t779djVFjS/mFwSV3wra1VnVnu4kSOKfPrZdxe0Ox8tvwU\r\n3rxfn3jPO2ZU8sb1ElGCi+Zmc7jwADFuGt4Q830CgYAKq0j3sDGtp9mwfqDf81vp\r\nygp68Jr8lMIzJhOa+WN2arWK9I6CiY/qSeF3zkIbhFNtPhalLQbpNEWvwW2VUePb\r\nVCgRRjSP976NinKOA6r/cRDSXBMmYp056iKKmjAIPFlTlzRpDOZjScGemR+qccn/\r\n3yWSSX3khRDrPBI/fHWM3wKBgQCNPCleBVEpFlYEle1k1qSM5FO9KKR+G54lPxCe\r\nK7N9VR1rjpqqaQH/4S7MI+dDEnIBVMZAh4bEBYb74+IK4/IzydyQVCzYOIt8bMoF\r\nwdkFajd7BAmBrB7xgC2b/cmCIwd/nIE08wyWP/90fkcZgYIVwOiWq5KQfPwC5N1a\r\nOUAE8QKBgAHC363/ozwt3AuEkhHBaCsDOHDVKN+6uXPoN1E2UMkAQ4UYdyS0vmDa\r\nhBp9kg8mM+Sdli90B+XdH6zDjRbR/W2TN6wkMps95B3OeHcAxl52zp9Xvq2opBfc\r\nTSorAWIrZbm/79FE9Pws7UAf1t7x5EvN7fl/MNEw90V/ZPJBa5eh";
    keyPairTests("zee-message-with!#\$#@\$!", pemPublicKey, pemPrivateKey);
  });

  test('Test Key Pair Set 2', () {
    const pemPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw7T+KEGcUb3PuJeRm+nR\r\nDaDI3LEr7ygKoYZG3971j87P4OQ5HXBOKkNO+RBkMqQiEgcTlWJ1to1zfM3CxLLh\r\nIdTWOKJXVP0XgNnIpIPyJPACyZAZ4uA1au2XNEhNhIJLnqfKz/6xxNNTn/j9g04J\r\nGYm6qAoyPyUiTB90t/gegx13zIRb7B7uQuiGSJlTyuEcB0rUlxnLuc1THshBH/KR\r\nvgO/hHYsHZTdCeZ2QzSTvlWo8qWNfhHjPw9HVulpdEx215Dek0TRaregZ6bQNeVP\r\nGQabZPLpRhZV5wYi03rHGqsnmYccXal3o10EextrEyD7AlfWSr0kIoIoHThv0M8h\r\newIDAQAB";
    const pemPrivateKey = "MIIEowIBAAKCAQEAw7T+KEGcUb3PuJeRm+nRDaDI3LEr7ygKoYZG3971j87P4OQ5\r\nHXBOKkNO+RBkMqQiEgcTlWJ1to1zfM3CxLLhIdTWOKJXVP0XgNnIpIPyJPACyZAZ\r\n4uA1au2XNEhNhIJLnqfKz/6xxNNTn/j9g04JGYm6qAoyPyUiTB90t/gegx13zIRb\r\n7B7uQuiGSJlTyuEcB0rUlxnLuc1THshBH/KRvgO/hHYsHZTdCeZ2QzSTvlWo8qWN\r\nfhHjPw9HVulpdEx215Dek0TRaregZ6bQNeVPGQabZPLpRhZV5wYi03rHGqsnmYcc\r\nXal3o10EextrEyD7AlfWSr0kIoIoHThv0M8hewIDAQABAoIBADhgBkiVYdDAIzqS\r\n2rx1daV91+6O0M+TEsDlu7vYb5dN5V7sjzFWPQX6nqCrYpmd4zybMj55ftwn0gk1\r\nAnKD7ss+krj8triCMYeJ9LzDT3jpdHwYmQRcPrb/GuvSGhZeLCdXQVp6DT5b+75c\r\nzLZKv99N5+lpCoFbEo6oDwjBnhR5YhFEeqfwwEywz1HUtBNpasmzj44ENaxK1bHu\r\nYgByUAs3iq0FDbgX3ONflE8tnj1N619gUgqnPDNh8ArNaaTVqdn8e0RZ1FzVWZeK\r\n5PNSOiwIw4LgtXrmbxfii5UOgda7iz2OUxu6rU7u33NJUTaDa/+haTm/M8PkoHxl\r\nWC2Q/DECgYEA/uyYK+KVNlfBy3TyaNCPzY6FzxDrs0AZOu4Eupe2QxXza0p06J+F\r\nkyM5ukuXYVGGOcktCzp610xbcNXgqj/aAlCvMk0Ra/GUa05CMAmr9374ny+1MYme\r\nFVGp8IPgOPnu1ApazWebeZnyzf1ehEUSzVc+wy+ZDRyowsmXuXBuyjECgYEAxIhs\r\nanMkDYhuGtUdwXYJN3w6xRPJqG69Y+v1DkfmmVAYqBOUFC9aoyVIlpWiZgRB6KHN\r\nmD0vjkFPbJZYTnXZ/H62slTKWskPRJK0X93NQlXk50FXO8kwyEO0TkAyqeH8isMm\r\nMn9Euna8gzM/OwflO4v1LOjJEMphrDThwrlzz2sCgYBFFheTZR+tD5Fssy/y6fre\r\n6W4oFNzbwlZUGyda7jyt56gFfrM6S+kmXBiL/Wp0LGTlCjlT3rBl4sKxTLVLTmyl\r\nzfn89tfu2hSwFBBp9mUNePKmKYbAexxFiNE2ZncA2fM4semz2w1OokMkQjM4Q4P5\r\n9FgFC8Q9wnOV/o5I6kiMMQKBgHApU4Zk89xtUjkqC3NPg+8QjRHQOzRPDvMpxI9D\r\n5Yz1szyo/8eNRvL44jZea3JBV8QGI6mQscVD7KoSG4+bnq6FOosH7Pxm5rnB6AMW\r\nOIB1OM/p8HkEVzzTtuE5rjBZ8qDWwsPq8jRgczGFW766wM59D41zxNw6RAfdnkJd\r\nSITFAoGBAJ3wXj6n0x6GFt57MQgRgaolM51oTzOEK5lnMjn9cnGfj6l9Z+eR/0vH\r\n42QEMFA94ZYFGh0H4RnvNh9lYHaciRcC2BcJsxH32iUyYct+Cx7qBnZLkD75T8tJ\r\n68nWzyPjPs4zAR180iO7tMidRkjkHZhsnbycOlu40sGUWfZjeIEY";
    keyPairTests("zee-message-with!#\$#@\$!", pemPublicKey, pemPrivateKey);
  });
}
