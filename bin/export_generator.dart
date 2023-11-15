library export_generator;

import 'dart:io';
import 'package:path/path.dart';
import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser()..addMultiOption('package', abbr: 'p');
  final args = parser.parse(arguments);
  generate(Directory(args.rest.last), ignorePatterns: args['package']);
}

Future<String?> generate(Directory currentDir,
    {List<String> ignorePatterns = const []}) async {
  String output = '';
  Future<void> processFile(File file, List<String> pathSegments) async {
    output += "export '${pathSegments.join('/')}';\n";
    final lines = await file.readAsLines();
    final lineToAdd = "import 'package:${ignorePatterns.first}/config.dart';";
    lines.insert(0, lineToAdd);
    await file.writeAsString(lines.join('\n'));
  }

  Future processDirectory(Directory dir, List<String> pathSegments) async {
    for (final entity in dir.listSync()) {
      if (entity is Directory) {
        processDirectory(entity, [...pathSegments, basename(entity.path)]);
      } else if (entity is File) {
        await processFile(entity, [...pathSegments, basename(entity.path)]);
      }
    }
  }

  if (!currentDir.existsSync()) {
    print('Error: The specified directory does not exist.');
    return null;
  }

  await processDirectory(currentDir, []);

  final outputFile = File('./lib/config.dart');
  try {
    outputFile.writeAsStringSync(output);
  } catch (e) {
    print('Error writing to output file: $e');
    return null;
  }

  print('Export file generated successfully.');
  return "${basename(currentDir.path)}.dart";
}

/* bool isIgnoring(String path, List<String> ignorePatterns) {
  for (var pattern in ignorePatterns) {
    if (path.contains(pattern)) return true;
  }
  return false;
} */
