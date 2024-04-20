import 'package:flutter/material.dart';
import 'package:notes_app/theme/light_theme.dart';

class BackgroundProvider extends ChangeNotifier{
    Color _bgColor = lightTheme.colorScheme.background;


    //Getter that return the current value of the color
    Color get bgColor => _bgColor;

    //Setter that sets the selected value to the background color
    set bgColor(Color bgColor){
      _bgColor = bgColor;
      notifyListeners();
    }

    //function that provides color to the setter 
    void changeColor(Color selectedColor){
      bgColor = selectedColor;
    }
}