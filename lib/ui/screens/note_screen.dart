import 'package:flutter/material.dart';

import '../../data/shared_prefs_settings.dart';
import '../../data/sql_helper.dart';
import '../../models/note.dart';
import 'notes_screen.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  final bool isNew;

  NoteScreen(this.note, this.isNew);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  int settingColor = 0xff1976D2;
  double fontSize = 16;
  SPSettings settings;
  SQLHelper helper;
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtNotes = TextEditingController();
  final TextEditingController txtDate = TextEditingController();

  @override
  void initState() {
    settings = SPSettings();
    helper = SQLHelper();
    settings.init().then((_) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    if (!widget.isNew) {
      txtName.text = widget.note.name;
      txtNotes.text = widget.note.notes;
      txtDate.text = widget.note.date;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isNew ? Text('Insert Note') : Text('Edit Note'),
        backgroundColor: Color(settingColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NoteText('Name', txtName, fontSize),
            NoteText('Description', txtNotes, fontSize),
            NoteText('Date', txtDate, fontSize),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          backgroundColor: Color(settingColor),
          onPressed: () {
            //save Note
            widget.note.name = txtName.text;
            widget.note.notes = txtNotes.text;
            widget.note.date = txtDate.text;
            widget.note.position = 0;

            if(widget.isNew){
              helper.newNote(widget.note);
            }else{
              helper.updateNote(widget.note);
            }
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>NotesScreen()));
          }),
    );
  }
}

class NoteText extends StatelessWidget {
  final String description;
  final TextEditingController controller;
  final double textSize;

  NoteText(this.description, this.controller, this.textSize);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: textSize,
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: description),
      ),
    );
  }
}