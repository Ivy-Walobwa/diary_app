import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/screens/home.dart';
import 'data/moor_db.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_)=>MoorDb(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen()
      ),
    );
  }
}
