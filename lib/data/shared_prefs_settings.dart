import 'package:shared_preferences/shared_preferences.dart';

class SPSettings{
  final String fontSize = 'font_size';
  final String colorKey = 'color';
  static SharedPreferences _sp;
  static SPSettings _instance;

  SPSettings._internal();

  // return instance already loaded
  factory SPSettings(){
    if(_instance == null){
      _instance = SPSettings._internal();
    }
    return _instance;
  }

  Future init()async{
    _sp = await SharedPreferences.getInstance();
  }

  Future setColor(int color){
    return _sp.setInt(colorKey, color);
  }

  int getColor(){
    int color = _sp.getInt(colorKey);
    if(color == null){
      color = 0xff4b778d;
    }
    return color;
  }

  Future setFontSize(double size){
    return _sp.setDouble(fontSize, size);
  }

  double getFontSize(){
    double size = _sp.getDouble(fontSize);
    if(size == null){
      size = 14;
    }
    return size;
  }
}