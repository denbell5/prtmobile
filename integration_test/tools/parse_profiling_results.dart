// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';

const rootDirPath = '../../';

void main(List<String> args) {
  // read files
  // read property and save to file as csv
  const resultDirPath = 'integration_test/expandable/test_results';
  final currPath = Directory.current.path;
  final resultDir = Directory(currPath + '/' + rootDirPath + resultDirPath);
  final files = resultDir.listSync().whereType<File>().where(
    (x) {
      return x.uri.pathSegments.last.contains('summary');
    },
  ).toList();

  final results = <Map<String, dynamic>>[];
  for (var file in files) {
    final jsonStr = file.readAsStringSync();
    final content = json.decode(jsonStr);
    results.add(content);
  }

  final average_frame_build_time_millis = <double>[];
  final frame_count = <int>[];
  final raster_frame_time = <double>[];

  for (var result in results) {
    average_frame_build_time_millis.add(
      result['average_frame_build_time_millis'] as double,
    );
    frame_count.add(
      result['frame_count'] as int,
    );
    raster_frame_time.add(
      result['average_frame_rasterizer_time_millis'] as double,
    );
  }

  final average_frame_build_time_millis_csv =
      average_frame_build_time_millis.join(',\n');
  final frame_count_csv = frame_count.join(',\n');
  final raster_frame_time_csv = raster_frame_time.join(',\n');
  print(average_frame_build_time_millis_csv);
  print('');
  print(frame_count_csv);
  print('');
  print(raster_frame_time_csv);
}
