import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:uuid/uuid.dart';

Future<File> downloadFile(String url) async {
  Uuid uuid = Uuid();

  String fileName = url.fileName;
  Directory directory = await getTemporaryDirectory();
  String directoryPath = "${directory.path}/${uuid.v1()}/$fileName";
  File file = File(directoryPath);
  return file;
}
