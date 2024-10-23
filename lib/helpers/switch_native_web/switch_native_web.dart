import 'native.dart' if (dart.library.html) 'web.dart' as switch_value;

Future<void> downloadFile(
    {required String url,
    required String fileName,
    required String dataType}) async {}

class SwitchNativeWeb {
  static void downloadFile(
      {required String url,
      required String fileName,
      required String dataType}) {
    switch_value.downloadFile(dataType: dataType, fileName: fileName, url: url);
  }
}
