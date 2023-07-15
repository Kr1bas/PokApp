import 'package:flutter/material.dart';
import 'package:pokapp/parallax_scrolling.dart';
import 'dart:math';

class NumberGuesserHomePage extends StatelessWidget {
  const NumberGuesserHomePage({super.key});

  List<DisplayPageItem> getNumberGuesserPageList() {
    final widgets = <DisplayPageItem>[];
    widgets.add(DisplayPageItem(
      navigateTo: NumberGuesserGamePage(min: 1, max: 151),
      title: "First Generation",
      subTitle: "Only the original 151!",
      assetImage: "assets/images/covers/pk_frlg.jpg",
    ));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PokAPP"),
      ),
      body: Center(
        child: SafeArea(
          child: ListView(children: getNumberGuesserPageList()),
        ),
      ),
    );
  }
}

class NumberGuesserGamePage extends StatefulWidget {
  NumberGuesserGamePage({super.key, required this.max, required this.min});

  int max;
  int min;
  @override
  State<NumberGuesserGamePage> createState() => _NumberGuesserGamePageState();
}

class _NumberGuesserGamePageState extends State<NumberGuesserGamePage> {
  int currentScore = 0;
  int currentPick = -1;

  final Random _rng = Random();

  @override
  void initState() {
    super.initState();
  }

  void next() {
    currentPick = _rng.nextInt(widget.max - 1) + widget.min;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    if (currentPick == -1) {
      children = <Widget>[
        TextButton(
            onPressed: (() => setState(() => next())),
            child: const Text("START!"))
      ];
    } else {
      children = [
        Text("Current Score: $currentScore"),
        Image.asset(
          "assets/images/dex/${currentPick < 10 ? '00$currentPick' : (currentPick < 100 ? '0$currentPick' : '$currentPick')}.png",
          scale: 1.5,
        ),
        TextButton(
            onPressed: () => setState(() => next()), child: const Text("Next!"))
      ];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("PokAPP"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
