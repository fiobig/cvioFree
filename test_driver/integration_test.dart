import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (name, bytes, [args]) async {
      final dir = Directory('screenshots');
      if (!dir.existsSync()) dir.createSync(recursive: true);
      final file = File('screenshots/$name.png');
      file.writeAsBytesSync(bytes);
      print('Screenshot saved: screenshots/$name.png');
      return true;
    },
  );
}
