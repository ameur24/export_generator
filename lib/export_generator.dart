library export_generator;

import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser()..addMultiOption('ignore', abbr: 'i');
  final args = parser.parse(arguments);

  generate(Directory(args.rest.last), ignorePatterns: args['ignore']);
}

String? generate(Directory currentDir,
    {List<String> ignorePatterns = const []}) {
  String output = '';

  void processFile(File file, List<String> pathSegments) {
    output += "export '${pathSegments.join('/')}';\n";
  }

  void processDirectory(Directory dir, List<String> pathSegments) {
    for (final entity in dir.listSync()) {
      if (entity is Directory) {
        processDirectory(entity, [...pathSegments, basename(entity.path)]);
      } else if (entity is File) {
        processFile(entity, [...pathSegments, basename(entity.path)]);
      }
    }
  }

  if (!currentDir.existsSync()) {
    log('Error: The specified directory does not exist.');
    return null;
  }

  processDirectory(currentDir, []);

  final outputFile = File('./lib/config.dart');
  try {
    outputFile.writeAsStringSync(output);
  } catch (e) {
    log('Error writing to output file: $e');
    return null;
  }

  log('Export file generated successfully.');
  return "${basename(currentDir.path)}.dart";
}
