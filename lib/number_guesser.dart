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
      navigateTo: NumberGuesserGamePage(
          min: Costants.kantoStart, max: Costants.kantoEnd, title: title),
      title: "First Generation",
      subTitle: "Only the original 151!",
      assetImage: "assets/images/covers/pk_frlg.jpg",
    ));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.jhotoStart, max: Costants.jhotoEnd, title: title),
        title: "Second Generation",
        subTitle: "Only Pokemons from the Jhoto region!",
        assetImage: "assets/images/covers/pk_hgss.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.hoennStart, max: Costants.hoennEnd, title: title),
        title: "Third Generation",
        subTitle: "Only Pokemons from the Hoenn region!",
        assetImage: "assets/images/covers/pk_rs.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.sinnohStart, max: Costants.sinnohEnd, title: title),
        title: "Fourth Generation",
        subTitle: "Only Pokemons from the Sinnoh region!",
        assetImage: "assets/images/covers/pk_dp.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.unovaStart, max: Costants.unovaEnd, title: title),
        title: "Fifth Generation",
        subTitle: "Only Pokemons from the Unima/Unova region!",
        assetImage: "assets/images/covers/pk_bw.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.kalosStart, max: Costants.kalosEnd, title: title),
        title: "Sixth Generation",
        subTitle: "Only Pokemons from the Kalos region!",
        assetImage: "assets/images/covers/pk_xy.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.alolaStart, max: Costants.alolaEnd, title: title),
        title: "Seventh Generation",
        subTitle: "Only Pokemons from the Alola region!",
        assetImage: "assets/images/covers/pk_usum.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.galarStart, max: Costants.galarEnd, title: title),
        title: "Eighth Generation",
        subTitle: "Only Pokemons from the Galar/Isui region!",
        assetImage: "assets/images/covers/pk_ss.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.paldeaStart, max: Costants.paldeaEnd, title: title),
        title: "Nineth Generation",
        subTitle: "Only Pokemons from the Paldea region!",
        assetImage: "assets/images/covers/pk_sv.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            min: Costants.absoluteStart,
            max: Costants.absoluteEnd,
            title: title),
        title: "Easy Mode",
        subTitle: "Don't worry you'll find out soon enough!",
        assetImage: "assets/images/other/pk_wp_3.jpg"));
    return widgets;
  }
}

class NumberGuesserGamePage extends StatefulWidget {
  const NumberGuesserGamePage(
      {super.key,
      required this.max,
      required this.min,
      required this.title,
      this.maxLives = Costants.maxLives});

  final String title;
  final int max;
  final int min;
  final int maxLives;
  @override
  State<NumberGuesserGamePage> createState() => _NumberGuesserGamePageState();
}

class _NumberGuesserGamePageState extends State<NumberGuesserGamePage> {
  int _currentScore = 0;
  int _currentPick = -1;
  int _currentLife = -1;
  bool _endOfGame = false;
  Widget _correctMessage = const Text("");
  int _scoreDelta = 0;
  int _lifeDelta = 0;
  final List<int> _alreadyExtracted = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _inputTextController = TextEditingController();
  final Random _rng = Random();

  int _calculateScore({required int answer, required int extracted}) {
    if (answer == extracted) return 10;
    if ((answer == extracted - 1) || (answer == extracted + 1)) return 8;
    if ((answer >= extracted - 5) && (answer <= extracted + 5)) return 6;
    if ((answer >= extracted - 10) && (answer <= extracted + 10)) return 4;
    if ((answer >= extracted - 20) && (answer <= extracted + 20)) return 2;
    if ((answer >= extracted - 30) && (answer <= extracted + 30)) return 1;
    return -1;
  }

  void _restart() {
    _formKey.currentState?.reset();
    _currentLife = widget.maxLives;
    _alreadyExtracted.removeWhere((element) => true);
    _currentScore = 0;
    setState(() {});
  }

  void _start() {
    _currentLife = 3;
    _currentPick = _rng.nextInt(widget.max - widget.min) + widget.min;
    _alreadyExtracted.add(_currentPick);
    setState(() {});
  }

  void _next() {
    _lifeDelta = 0;
    if (_formKey.currentState!.validate()) {
      _scoreDelta = _calculateScore(
          answer: int.parse(_inputTextController.text),
          extracted: _currentPick);
      if (_scoreDelta > 0) {
        _currentScore += _scoreDelta;
        if (_scoreDelta == 10) {
          _correctMessage = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Correct! Pokémon number ${_inputTextController.text} is: "),
              SizedBox(
                width: 20,
                child: Image.asset(
                  "assets/images/dex/${int.parse(_inputTextController.text) < 10 ? '00${int.parse(_inputTextController.text)}' : (int.parse(_inputTextController.text) < 100 ? '0${int.parse(_inputTextController.text)}' : '${int.parse(_inputTextController.text)}')}.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
          if (_currentLife < widget.maxLives) {
            _currentLife += 1;
            _lifeDelta = 1;
          }
        } else {
          _correctMessage = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Close! Pokémon number ${_inputTextController.text} is: "),
              SizedBox(
                width: 20,
                child: Image.asset(
                  "assets/images/dex/${int.parse(_inputTextController.text) < 10 ? '00${int.parse(_inputTextController.text)}' : (int.parse(_inputTextController.text) < 100 ? '0${int.parse(_inputTextController.text)}' : '${int.parse(_inputTextController.text)}')}.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        }
      } else {
        _correctMessage = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wrong! Pokémon number ${_inputTextController.text} is: "),
            SizedBox(
              width: 20,
              child: Image.asset(
                "assets/images/dex/${int.parse(_inputTextController.text) < 10 ? '00${int.parse(_inputTextController.text)}' : (int.parse(_inputTextController.text) < 100 ? '0${int.parse(_inputTextController.text)}' : '${int.parse(_inputTextController.text)}')}.png",
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
        _currentLife -= 1;
        _lifeDelta = -1;
      }
      _formKey.currentState!.reset();
    }
    if (_alreadyExtracted.length == (widget.max - widget.min)) {
      _endOfGame = true;
    }
    do {
      _currentPick = _rng.nextInt(widget.max - widget.min) + widget.min;
    } while (_alreadyExtracted.contains(_currentPick));
    _alreadyExtracted.add(_currentPick);
    setState(() {});
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
    if (_lifeDelta > 0) {
      icons.add(Text(
        ' +$_lifeDelta',
        style: Costants.coloredTextStyle(
            context, Colors.green, Theme.of(context).textTheme.headlineSmall!),
      ));
    }
    if (_lifeDelta < 0) {
      icons.add(Text(
        ' $_lifeDelta',
        style: Costants.coloredTextStyle(
            context, Colors.red, Theme.of(context).textTheme.headlineSmall!),
      ));
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    print(_currentPick);
    Widget child;
    if (_currentPick == -1) {
      child = Center(
        child: ElevatedButton(
          onPressed: (() => _start()),
          child: const Text("START!"),
        ),
      );
    } else if (_currentLife == 0 || _endOfGame) {
      child = Column(children: [
        SizedBox(
          width: 300,
          child: ListTile(
            title: const Text("You final score is:"),
            trailing: Text("$_currentScore"),
          ),
        ),
        ElevatedButton(
          onPressed: (() => _restart()),
          child: const Text("RESTART!"),
        )
      ]);
    } else {
      child = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Current Score: $_currentScore",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                _scoreDelta > 0 ? '+$_scoreDelta' : '',
                style: Costants.coloredTextStyle(context, Colors.green,
                    Theme.of(context).textTheme.headlineSmall!),
              ),
            ]),
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
              child: Column(children: [
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
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
                _correctMessage,
                ElevatedButton(
                    onPressed: (() => _next()), child: const Text("Next!")),
              ]),
            ),
          ]);
    }
    return GamePageScaffold(title: widget.title, child: child);
  }
}
