import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'files.dart';
import 'package:share/share.dart';
import '../../data/file_helper.dart';
import '../../data/shared_prefs_settings.dart';

class FileScreen extends StatefulWidget {
  final File file;

  FileScreen(this.file);

  @override
  _FileScreenState createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  int settingColor = 0xff1976D2;
  double fontSize = 16;
  SPSettings settings;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FileHelper helper;

  @override
  void initState() {
    super.initState();

    settings = SPSettings();
    settings.init().then((_) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    helper = FileHelper();
    if (widget.file == null) {
      titleController.text = 'New File';
      contentController.text = '';
    } else {
      titleController.text = basename(widget.file.path);
      helper
          .readFromFile(widget.file)
          .then((value) => contentController.text = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: titleController,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
        backgroundColor: Color(settingColor),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              saveFile().then((value) =>
                  Share.shareFiles(
                      [widget.file.path], text: basename(widget.file.path))
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              controller: contentController,
              style: TextStyle(fontSize: fontSize),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Color(settingColor),
        onPressed: () {
          saveFile();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => FilesScreen()));
        },
      ),
    );
  }

  Future saveFile() async {
    helper.writeToFile(titleController.text, contentController.text);
  }
}
