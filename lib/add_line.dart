import 'dart:io';

Future<void> addLineToFile(String filePath, String lineToAdd) async {
  final file = File(filePath);
  final lines = await file.readAsLines();

  lines.insert(0, lineToAdd);

  await file.writeAsString(lines.join('\n'));
}
