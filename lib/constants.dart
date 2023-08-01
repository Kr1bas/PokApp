import 'package:flutter/material.dart';

class Costants {
  // Various constants
  static const int maxLives = 3;
  // DB constants
  static const String generationGuesserID = 'generationGuesser';
  static const String numberGuesserID = 'numberGuesser';
  static const String categoryAll = 'all';
  static const String categoryShadow = 'shadow';
  static const String categoryKanto = 'kanto';
  static const String categoryJhoto = 'jhoto';
  static const String categoryHoenn = 'hoenn';
  static const String categorySinnoh = 'sinnoh';
  static const String categoryUnova = 'unova';
  static const String categoryKalos = 'kalos';
  static const String categoryAlola = 'alola';
  static const String categoryGalar = 'galar';
  static const String categoryPaldea = 'paldea';
  // Regional pokedex indexes

  static const int kantoStart = 1;
  static const int kantoEnd = 151;
  static const int jhotoStart = 152;
  static const int jhotoEnd = 251;
  static const int hoennStart = 252;
  static const int hoennEnd = 386;
  static const int sinnohStart = 387;
  static const int sinnohEnd = 493;
  static const int unovaStart = 494;
  static const int unovaEnd = 649;
  static const int kalosStart = 650;
  static const int kalosEnd = 721;
  static const int alolaStart = 722;
  static const int alolaEnd = 809;
  static const int galarStart = 810;
  static const int galarEnd = 905;
  static const int paldeaStart = 906;
  static const int paldeaEnd = 1010;
  static const int absoluteStart = kantoStart;
  static const int absoluteEnd = paldeaEnd;
  //Style constants
  static TextStyle coloredTextStyle(
      BuildContext context, Color color, TextStyle baseStyle) {
    return TextStyle(
      color: color,
      fontFamily: baseStyle.fontFamily,
      fontFamilyFallback: baseStyle.fontFamilyFallback,
      fontFeatures: baseStyle.fontFeatures,
      fontSize: baseStyle.fontSize,
      fontStyle: baseStyle.fontStyle,
      fontVariations: baseStyle.fontVariations,
      fontWeight: baseStyle.fontWeight,
      foreground: baseStyle.foreground,
      wordSpacing: baseStyle.wordSpacing,
      height: baseStyle.height,
      overflow: baseStyle.overflow,
      textBaseline: baseStyle.textBaseline,
      decorationThickness: baseStyle.decorationThickness,
      background: baseStyle.background,
      backgroundColor: baseStyle.backgroundColor,
      decorationColor: baseStyle.decorationColor,
      debugLabel: baseStyle.debugLabel,
      decoration: baseStyle.decoration,
      decorationStyle: baseStyle.decorationStyle,
      leadingDistribution: baseStyle.leadingDistribution,
      letterSpacing: baseStyle.letterSpacing,
      locale: baseStyle.locale,
      shadows: baseStyle.shadows,
    );
  }
}
