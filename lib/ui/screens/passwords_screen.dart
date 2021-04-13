import 'package:flutter/material.dart';

import '../../data/shared_prefs_settings.dart';
import 'password_detail_dialog.dart';
import '../../models/password.dart';
import '../../data/sembast_db.dart';

class PasswordsScreen extends StatefulWidget {
  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;
  SembastDb db;

  @override
  void initState() {
    db = SembastDb();
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  Future getPasswords() async {
    List<Password> passwords = await db.getPasswords();
    return passwords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passwords List'),
        backgroundColor: Color(settingColor),
      ),
      body: FutureBuilder(
        future: getPasswords(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Password> passwords = snapshot.data;
          return ListView.builder(
            itemBuilder: (_, idx) {
              Password pwd = passwords[idx];
              return Dismissible(
                key: Key(pwd.id.toString()),
                child: ListTile(
                  title: Text(
                    pwd.name,
                    style: TextStyle(fontSize: fontSize),
                  ),
                  trailing: Icon(Icons.edit),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => PasswordDetailDialog(pwd, false));
                  },
                ),
                onDismissed: (_) {
                  db.deletePassword(pwd);
                },
              );
            },
            itemCount: passwords == null ? 0 : passwords.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(settingColor),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return PasswordDetailDialog(
                      Password(name: '', password: ''), true);
                });
          }),
    );
  }
}
