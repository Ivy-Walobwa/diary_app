import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/shared_prefs_settings.dart';
import '../../models/font_size_model.dart';
import '../widgets/circular_container.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int settingColor = 0xff4b778d;
  double fontSize = 16;
  List<int> colors = [
    0xffff8882,
    0xff81b214,
    0xffce1212,
    0xffffcc29,
    0xff150e56,
    0xffdbf6e9,
    0xff93329e,
    0xffb4aee8,
    0xffffe3fe,
    0xffd49d42,
  ];

  List<IFontSize> fontSizes = [
    IFontSize(size: 16, name: 'small'),
    IFontSize(size: 22, name: 'medium'),
    IFontSize(size: 28, name: 'large'),
    IFontSize(size: 34, name: 'extra-large'),
  ];

  SPSettings settings;

  @override
  void initState() {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  void setColor(int color) {
    setState(() {
      settingColor = color;
      settings.setColor(color);
    });
  }

  void changeSize(String newSize) {
    double size = double.tryParse(newSize);
    settings.setFontSize(size);
    setState(() {
      fontSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: TextStyle(fontSize: fontSize),),
        backgroundColor: Color(settingColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Choose font size for app',
              style: TextStyle(fontSize: fontSize)),
          DropdownButton(
            items: getDropDownMenuItems(),
            value: fontSize.toString(),
            onChanged: changeSize,
          ),
          Text('App main color'),
          Container(
            height: 85,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                colors.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: CircularContainer(colorCode: colors[index]),
                    onTap: () => setColor(colors[index]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (IFontSize fontSize in fontSizes) {
      items.add(DropdownMenuItem(
        value: fontSize.size.toString(),
        child: Text(fontSize.name),
      ));
    }
    return items;
  }
}
