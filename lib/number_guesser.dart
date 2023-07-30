import 'package:pokapp/constants.dart';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokapp/game_page_interface.dart';
import 'package:pokapp/parallax_scrolling.dart';
import 'dart:math';

const int maxLives = 3;

class NumberGuesserHomePage extends GameHomePage {
  const NumberGuesserHomePage(
      {super.key, required super.gameID, required super.title});

  @override
  List<DisplayPageItem> getGamePageList() {
    final widgets = <DisplayPageItem>[];
    widgets.add(DisplayPageItem(
      navigateTo:
          NumberGuesserGamePage(min: kantoStart, max: kantoEnd, title: title),
      title: "First Generation",
      subTitle: "Only the original 151!",
      assetImage: "assets/images/covers/pk_frlg.jpg",
    ));
    widgets.add(DisplayPageItem(
        navigateTo:
            NumberGuesserGamePage(min: jhotoStart, max: jhotoEnd, title: title),
        title: "Second Generation",
        subTitle: "Only Pokemons from the Jhoto region!",
        assetImage: "assets/images/covers/pk_hgss.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo:
            NumberGuesserGamePage(min: hoennStart, max: hoennEnd, title: title),
        title: "Third Generation",
        subTitle: "Only Pokemons from the Hoenn region!",
        assetImage: "assets/images/covers/pk_rs.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: sinnohStart, max: sinnohEnd, title: title),
        title: "Fourth Generation",
        subTitle: "Only Pokemons from the Sinnoh region!",
        assetImage: "assets/images/covers/pk_dp.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo:
            NumberGuesserGamePage(min: unovaStart, max: unovaEnd, title: title),
        title: "Fifth Generation",
        subTitle: "Only Pokemons from the Unima/Unova region!",
        assetImage: "assets/images/covers/pk_bw.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo:
            NumberGuesserGamePage(min: kalosStart, max: kalosEnd, title: title),
        title: "Sixth Generation",
        subTitle: "Only Pokemons from the Kalos region!",
        assetImage: "assets/images/covers/pk_xy.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo:
            NumberGuesserGamePage(min: alolaStart, max: alolaEnd, title: title),
        title: "Seventh Generation",
        subTitle: "Only Pokemons from the Alola region!",
        assetImage: "assets/images/covers/pk_usum.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo:
            NumberGuesserGamePage(min: galarStart, max: galarEnd, title: title),
        title: "Eighth Generation",
        subTitle: "Only Pokemons from the Galar/Isui region!",
        assetImage: "assets/images/covers/pk_ss.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: paldeaStart, max: paldeaEnd, title: title),
        title: "Nineth Generation",
        subTitle: "Only Pokemons from the Paldea region!",
        assetImage: "assets/images/covers/pk_sv.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: absoluteStart, max: absoluteEnd, title: title),
        title: "Easy Mode",
        subTitle: "Don't worry you'll find out soon enough!",
        assetImage: "assets/images/other/pk_wp_3.jpg"));
    return widgets;
  }
}

class NumberGuesserGamePage extends StatefulWidget {
  const NumberGuesserGamePage(
      {super.key, required this.max, required this.min, required this.title});

  final String title;
  final int max;
  final int min;
  @override
  State<NumberGuesserGamePage> createState() => _NumberGuesserGamePageState();
}

class _NumberGuesserGamePageState extends State<NumberGuesserGamePage> {
  int _currentScore = 0;
  int _currentPick = -1;
  int _currentLife = -1;
  bool _endOfGame = false;
  final List<int> _alreadyExtracted = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _inputTextController = TextEditingController();
  final Random _rng = Random();

  void _restart() {
    _alreadyExtracted.removeWhere((element) => true);
    _currentScore = 0;
    _start();
  }

  void _start() {
    _currentLife = 3;
    _currentPick = _rng.nextInt(widget.max - widget.min) + widget.min;
    _alreadyExtracted.add(_currentPick);
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      if (int.parse(_inputTextController.text) == _currentPick) {
        _currentScore += 1;
        if (_currentScore == (widget.max - widget.min)) {
          _endOfGame = true;
        } else {
          do {
            _currentPick = _rng.nextInt(widget.max - widget.min) + widget.min;
          } while (_alreadyExtracted.contains(_currentPick));
          _alreadyExtracted.add(_currentPick);
        }
      } else {
        _currentLife -= 1;
        if (_currentLife == 0) {
          _inputTextController.dispose();
        }
      }
      _formKey.currentState!.reset();
    }
  }

  List<Widget> _getCurrentLifeIcons() {
    List<Widget> icons = [];
    for (var i = 0; i < _currentLife; i++) {
      icons.add(const Icon(
        Icons.favorite,
        color: Colors.red,
      ));
    }
    for (var i = 0; i < (maxLives - _currentLife); i++) {
      icons.add(const Icon(
        Icons.heart_broken,
        color: Colors.black12,
      ));
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_currentPick == -1) {
      child = Center(
        child: ElevatedButton(
          onPressed: (() => setState(() => _start())),
          child: const Text("START!"),
        ),
      );
    } else if (_currentLife == 0) {
      child = Column(children: [
        SizedBox(
          width: 300,
          child: ListTile(
            title: const Text("You final score is:"),
            trailing: Text("$_currentScore"),
          ),
        ),
        ElevatedButton(
          onPressed: (() => setState(() => _restart())),
          child: const Text("RESTART!"),
        )
      ]);
    } else {
      child = child = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "Current Score: $_currentScore",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getCurrentLifeIcons(),
            ),
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                "assets/images/dex/${_currentPick < 10 ? '00$_currentPick' : (_currentPick < 100 ? '0$_currentPick' : '$_currentPick')}.png",
                fit: BoxFit.contain,
              ),
            ),
            Form(
              key: _formKey,
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  controller: _inputTextController,
                  decoration: const InputDecoration(
                      hintText: "Insert Pokedex number here"),
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  maxLength: 4,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    int ival = int.parse(value);
                    if (ival < widget.min || ival > widget.max) {
                      return 'Value must be between ${widget.min} and ${widget.max}.';
                    }
                    return null;
                  }),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => setState(() => _next()),
                child: const Text("Next!")),
          ]);
    }
    return GamePageScaffold(title: widget.title, child: child);
  }
}
