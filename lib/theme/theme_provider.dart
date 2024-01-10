import 'package:flutter/material.dart';
import 'package:notes/theme/theme.dart';


class ThemeProvider extends ChangeNotifier{
  // initially theme is light
  ThemeData _themeData = lightMode;
  // to access theme from other parts of the code
  ThemeData get themeData => _themeData;
  // to see if we are in dark mode or not
  bool get isDarkMode => _themeData == darkMode;
  // To set new theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
  // to use this as a toggle switch
  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}