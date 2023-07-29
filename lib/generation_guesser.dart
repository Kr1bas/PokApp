import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokapp/constants.dart';
import 'package:pokapp/parallax_scrolling.dart';
import 'dart:math';
import 'package:pokapp/leaderbord.dart';
import 'package:pokapp/game_page_interface.dart';

class GenerationGuesserHomePage extends GameHomePage {
  const GenerationGuesserHomePage(
      {super.key, required super.gameID, required super.title});

  @override
  List<DisplayPageItem> getGamePageList() {
    final widgets = <DisplayPageItem>[];
    widgets.add(DisplayPageItem(
      navigateTo: Text('placeholer'),
      /* GenerationGuesserGamePage(
        categoryID: 'all',
        gameID: gameID,
      ), */
      title: "Every Generation!",
      subTitle: "Only every pokemon ever made!",
      assetImage: "assets/images/other/pk_wp_3.jpg",
    ));
    return widgets;
  }
}

class GenerationGuesserGamePage extends GameCategoryPage {
  const GenerationGuesserGamePage({
    super.key,
    required super.title,
    required super.gameID,
    required super.categoryID,
    required super.rangeEnd,
    required super.rangeStart,
    required super.maxLives,
    required super.inputMaxLength,
  });

  @override
  State<GenerationGuesserGamePage> createState() =>
      _GenerationGuesserGamePageState();
}

class _GenerationGuesserGamePageState extends State<GenerationGuesserGamePage> {
  @override
  void initState() {
    super.initState();
  }

  int _generation(int index) {
    if (index <= kantoEnd) return 1;
    if (index <= jhotoEnd) return 2;
    if (index <= hoennEnd) return 3;
    if (index <= sinnohEnd) return 4;
    if (index <= unovaEnd) return 5;
    if (index <= kalosEnd) return 6;
    if (index <= alolaEnd) return 7;
    if (index <= galarEnd) return 8;
    if (index <= paldeaEnd) return 9;
    return -1;
  }

  @override
  bool _isCorrectAnswer({required String answer, required int currentPick}) {
    return int.parse(answer) == _generation(currentPick);
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
