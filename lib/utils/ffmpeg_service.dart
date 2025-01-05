// ffmpeg_service.dart
// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:typed_data';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'dart:html' as html;

class FFmpegService {
  FFmpeg? _ffmpeg;
  Function(double)? onProgress;
  Function(String)? onLog;
  int progressCount = 1;
  double progress = 0;
  // final String outputDir = '/transcoding';

  FFmpegService({
    this.onProgress,
    this.onLog,
  });

  Future<void> loadFFmpeg() async {
    _ffmpeg = createFFmpeg(
      CreateFFmpegParam(
        log: true,
        corePath: "https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js",
      ),
    );

    _ffmpeg?.setProgress(_onProgressHandler);
    _ffmpeg?.setLogger(_onLogHandler);

    await _ffmpeg?.load();
  }

  void _onProgressHandler(ProgressParam progress) {
    if (onProgress != null) {
      this.progress = progress.ratio;
      double overallProgress = ((progressCount - 1) + this.progress) / 3;
      onProgress!(overallProgress);
    }
  }

  static final regex = RegExp(
    r'frame\s*=\s*(\d+)\s+fps\s*=\s*(\d+(?:\.\d+)?)\s+q\s*=\s*([\d.-]+)\s+L?size\s*=\s*(\d+)\w*\s+time\s*=\s*([\d:\.]+)\s+bitrate\s*=\s*([\d.]+)\s*(\w+)/s\s+speed\s*=\s*([\d.]+)x',
  );

  void _onLogHandler(LoggerParam logger) {
    if (logger.type == 'fferr') {
      final match = regex.firstMatch(logger.message);

      if (match != null) {
        final frame = match.group(1);
        final fps = match.group(2);
        final q = match.group(3);
        final size = match.group(4);
        final time = match.group(5);
        final bitrate = match.group(6);
        final bitrateUnit = match.group(7);
        final speed = match.group(8);

        if (onLog != null) {
          onLog!(
              'frame: $frame, fps: $fps, q: $q, size: $size, time: $time, bitrate: $bitrate$bitrateUnit, speed: $speed');
        }
      }
    }
  }

  Future<Map<String, List<dynamic>>> transcodeToM3U8(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    Uint8List fileBytes = reader.result as Uint8List;

    _ffmpeg?.writeFile(file.name, fileBytes);

    // await _ffmpeg.run([
    //   '-i',
    //   file.name,
    //   // 360p
    //   '-vf',
    //   'scale=640:-2',
    //   '-c:a',
    //   'copy',
    //   '-f',
    //   'hls',
    //   '360p.m3u8',
    //   // 720p
    //   '-vf',
    //   'scale=1280:-2',
    //   '-c:a',
    //   'copy',
    //   '-f',
    //   'hls',
    //   '720p.m3u8',
    //   // 1080p
    //   '-vf',
    //   'scale=1920:-2',
    //   '-c:a',
    //   'copy',
    //   '-f',
    //   'hls',
    //   '1080p.m3u8',
    // ]);

    await _ffmpeg?.run([
      '-i',
      file.name,
      // 360p
      '-vf',
      'scale=640:-2',
      '-c:a',
      'copy',
      '-f',
      'hls',
      '360p.m3u8',
    ]);

    progressCount++;
    progress = 0;

    await _ffmpeg?.run([
      '-i',
      file.name,
      // 720p
      '-vf',
      'scale=1280:-2',
      '-c:a',
      'copy',
      '-f',
      'hls',
      '720p.m3u8',
    ]);

    progressCount++;
    progress = 0;

    await _ffmpeg?.run([
      '-i',
      file.name,
      // 1080p
      '-vf',
      'scale=1920:-2',
      '-c:a',
      'copy',
      '-f',
      'hls',
      '1080p.m3u8',
    ]);

    final playlist = _ffmpeg?.readDir("/");

    List<String> files = [];
    List<Uint8List> datas = [];

    files.add("1080p.m3u8");
    Uint8List data = _ffmpeg!.readFile("1080p.m3u8");
    datas.add(data);
    files.add("720p.m3u8");
    data = _ffmpeg!.readFile("720p.m3u8");
    datas.add(data);
    files.add("360p.m3u8");
    data = _ffmpeg!.readFile("360p.m3u8");
    datas.add(data);

    for (int i = 0; i < playlist!.length; i++) {
      if (playlist[i].contains(".ts")) {
        files.add(playlist[i]);
        data = _ffmpeg!.readFile(playlist[i]);
        datas.add(data);
      }
    }

    return {"filename": files, "data": datas};
  }

  void dispose() {
    _ffmpeg?.exit();
  }
}
