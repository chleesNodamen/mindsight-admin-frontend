import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
// ignore: deprecated_member_use
import 'dart:html' as html;

class BlobNameGenerator {
  static String generateBlobName(html.File file) {
    const Uuid uuid = Uuid();
    String uniqueFileName = uuid.v4();
    String extension = path.extension(file.name);
    return '$uniqueFileName$extension';
  }

  static String generateBlobFolderName() {
    const Uuid uuid = Uuid();
    String uniqueFileName = uuid.v4();
    return uniqueFileName;
  }
}
