import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:dart_encrypt_text/dart_encrypt_text.dart' as enctext;

//generate secret key
var secretKey = enctext.generateRandomString(32);

void main(List<String> arguments) async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  if (env.isDefined("SECRET_KEY")) {
    secretKey = '${env['SECRET_KEY']}';
  }

  print(
      "##############################################################################################");
  print("* Dart CLI App: Encrypt & Decrypt Text");
  print(
      "- Desc: cli application to encrypt and decrypt text base on custom or generated secret key.");
  print("- Note: .env file is required to set a custom secret key.");
  print("- Author: Afif-Dev https://github.com/afif-dev");
  print(
      "##############################################################################################\n");

  await menuList();

  exit(0);
}

Future<void> menuList() async {
  int i = 0;
  do {
    print("[1] Encrypt Text.");
    print("[2] Decrypt Text.");
    print("[0] Exit.");

  
    try {
      stdout.writeln("Type a number:");
      var menuNum = stdin.readLineSync();
      var menuNumInt = int.parse(menuNum!);

      switch (menuNumInt) 
      {
        case 0:
          print("exit, bye!");
          i = 1;
          break;
        case 1:
          print("-> Encrypt Text");
          stdout.writeln("Type a text:");
          var plainText = stdin.readLineSync();
          var encryptedText =
              enctext.setEncryptedText(secretKey, plainText.toString());
          await enctext.saveAsText(secretKey, encryptedText);
          print(
              "--------------------------------------------------------------------------------------");
          print("Secret Key: $secretKey");
          print("Encrypted Text: $encryptedText");
          print("\n*saved into dart_encypt_text.txt");
          print(
              "--------------------------------------------------------------------------------------\n");
          break;
        case 2:
          print("-> Decrypt Text");
          stdout.writeln("Type a secret key: (ignore if use current secret key)");
          var secretKeyIn = stdin.readLineSync();
          secretKeyIn = (secretKeyIn != "" ? secretKeyIn : secretKey);
          stdout.writeln("Type a encrypted text:");
          var encryptedTextIn = stdin.readLineSync();
          try {
            var decryptedText = enctext.getDecryptedText(secretKeyIn.toString(), encryptedTextIn.toString());
            print(
                "--------------------------------------------------------------------------------------");
            print("Decrypted Text:\n$decryptedText");
            print(
                "--------------------------------------------------------------------------------------\n");
          } catch (e) {
            print("Invalid secret key & encrypted text!\n");
          }

          break;
      }
    } catch (e) {
        print("Invalid input!\n");
    }
    
  } while (i < 1);
    
 
    
}
