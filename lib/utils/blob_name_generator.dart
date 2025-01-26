// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
import 'dart:html' as html;

class BlobNameGenerator {
  static String generateBlobName(html.File photoFile) {
    const Uuid uuid = Uuid();
    String uniqueFileName = uuid.v4();
    String extension = path.extension(photoFile.name);
    return '$uniqueFileName$extension';
  }

  static String generateFolderName() {
    const Uuid uuid = Uuid();
    String uniqueFileName = uuid.v4();
    return uniqueFileName;
  }
}
