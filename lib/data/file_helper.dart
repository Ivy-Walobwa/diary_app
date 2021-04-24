import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class FileHelper{
  Future<String> get _docsPath async{
    final Directory dir = await getApplicationDocumentsDirectory();
    String fullPath = join(dir.path,'globefiles');
    Directory globeDir = Directory(fullPath);

    if(!globeDir.existsSync()){
      await globeDir.create();
    }
    return fullPath;
  }

  Future<List<File>> getFiles() async{
    final String dirPath = await _docsPath;
    List<File> files = [];
    List<FileSystemEntity> fse = Directory(dirPath).listSync();
    fse.forEach((element) {
      if(element is File){
        files.add(element);
      }
    });
    return files;
  }

  Future writeToFile(String fileName, String content)async{
    final String dirPath = await _docsPath;
    final String filePath = join(dirPath,fileName);
    File file = File(filePath);
    return file.writeAsString(content);

  }

  Future<String> readFromFile(File file)async{
    String content = await file.readAsString();
    return content;
  }
  Future deleteFile(File file)async{
    await file.delete();
  }


}