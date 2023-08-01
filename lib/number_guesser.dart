import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokapp/game_page_interface.dart';
import 'package:pokapp/leaderbord.dart';
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
          gameID: gameID,
          categoryID: Costants.categoryKanto,
          rangeStart: Costants.kantoStart,
          rangeEnd: Costants.kantoEnd,
          title: title),
      title: "First Generation",
      subTitle: "Only the original 151!",
      assetImage: "assets/images/covers/pk_frlg.jpg",
    ));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryJhoto,
            rangeStart: Costants.jhotoStart,
            rangeEnd: Costants.jhotoEnd,
            title: title),
        title: "Second Generation",
        subTitle: "Only Pokemons from the Jhoto region!",
        assetImage: "assets/images/covers/pk_hgss.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryHoenn,
            rangeStart: Costants.hoennStart,
            rangeEnd: Costants.hoennEnd,
            title: title),
        title: "Third Generation",
        subTitle: "Only Pokemons from the Hoenn region!",
        assetImage: "assets/images/covers/pk_rs.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categorySinnoh,
            rangeStart: Costants.sinnohStart,
            rangeEnd: Costants.sinnohEnd,
            title: title),
        title: "Fourth Generation",
        subTitle: "Only Pokemons from the Sinnoh region!",
        assetImage: "assets/images/covers/pk_dp.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryUnova,
            rangeStart: Costants.unovaStart,
            rangeEnd: Costants.unovaEnd,
            title: title),
        title: "Fifth Generation",
        subTitle: "Only Pokemons from the Unima/Unova region!",
        assetImage: "assets/images/covers/pk_bw.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryKalos,
            rangeStart: Costants.kalosStart,
            rangeEnd: Costants.kalosEnd,
            title: title),
        title: "Sixth Generation",
        subTitle: "Only Pokemons from the Kalos region!",
        assetImage: "assets/images/covers/pk_xy.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryAlola,
            rangeStart: Costants.alolaStart,
            rangeEnd: Costants.alolaEnd,
            title: title),
        title: "Seventh Generation",
        subTitle: "Only Pokemons from the Alola region!",
        assetImage: "assets/images/covers/pk_usum.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryGalar,
            rangeStart: Costants.galarStart,
            rangeEnd: Costants.galarEnd,
            title: title),
        title: "Eighth Generation",
        subTitle: "Only Pokemons from the Galar/Isui region!",
        assetImage: "assets/images/covers/pk_ss.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryPaldea,
            rangeStart: Costants.paldeaStart,
            rangeEnd: Costants.paldeaEnd,
            title: title),
        title: "Nineth Generation",
        subTitle: "Only Pokemons from the Paldea region!",
        assetImage: "assets/images/covers/pk_sv.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NumberGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryAll,
            rangeStart: Costants.absoluteStart,
            rangeEnd: Costants.absoluteEnd,
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
      required this.rangeEnd,
      required this.rangeStart,
      required this.gameID,
      required this.categoryID,
      required this.title,
      this.maxLives = Costants.maxLives});

  final String title;
  final int rangeEnd;
  final int rangeStart;
  final int maxLives;
  final String gameID;
  final String categoryID;

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
  final GlobalKey<FormState> _leaderboardFormKey = GlobalKey<FormState>();
  final _leaderboardInputTextController = TextEditingController();
  bool _leaderboardSubmitted = false;
  late final Leaderboard _leaderboard;

  @override
  void initState() {
    Leaderboard.getLeaderboard(game: widget.gameID, category: widget.categoryID)
        .then((value) {
      _leaderboard = value;
    });
    super.initState();
  }

  int _calculateScore({required int answer, required int extracted}) {
    if (answer == extracted) return 10;
    if ((answer == extracted - 1) || (answer == extracted + 1)) return 8;
    if ((answer >= extracted - 2) && (answer <= extracted + 2)) return 6;
    if ((answer >= extracted - 4) && (answer <= extracted + 4)) return 4;
    if ((answer >= extracted - 8) && (answer <= extracted + 8)) return 2;
    if ((answer >= extracted - 16) && (answer <= extracted + 16)) return 1;
    return -1;
  }

  void _restart() {
    _formKey.currentState?.reset();
    _currentLife = widget.maxLives;
    _alreadyExtracted.removeWhere((element) => true);
    _currentScore = 0;
    _scoreDelta = 0;
    _lifeDelta = 0;
    _correctMessage = const Text("");
    _start();
  }

  void _start() {
    _currentLife = 3;
    _currentPick =
        _rng.nextInt(widget.rangeEnd - widget.rangeStart) + widget.rangeStart;
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
    if (_alreadyExtracted.length == (widget.rangeEnd - widget.rangeStart)) {
      _endOfGame = true;
    }
    do {
      _currentPick =
          _rng.nextInt(widget.rangeEnd - widget.rangeStart) + widget.rangeStart;
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

  void _submit() {
    if (_leaderboardSubmitted) return;
    if (_leaderboardFormKey.currentState!.validate()) {
      _leaderboard.uploadScoreToLeaderboard(
        score: LeaderboardMember(
            name: _leaderboardInputTextController.text,
            score: _currentScore,
            timestamp: Timestamp.now()),
      );
      _leaderboardSubmitted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_currentPick == -1) {
      child = Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/other/pk_oak_frlg.png"),
            const Text(
              "Rules:",
              style: TextStyle(fontFamily: "VT323", fontSize: 20),
            ),
            Center(
              child: Stack(children: <Widget>[
                Image.asset("assets/images/other/pk_textbox.png",
                    width: 400, height: 190, fit: BoxFit.fill),
                const SizedBox(
                  width: 400,
                  child: AspectRatio(
                    aspectRatio: 4 / 1.9,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, top: 2),
                        child: Text(
                          "You have to guess the Pokédex number of the shown Pokémon.\nScoring goes as follows:\n+ 10 Pts & +1 Life (Max 3) for the correct number;\n+ 8 Pts for number ± 1;\n+ 6 Pts for the number ±2;\n+ 4 Pts for the number ±4\n+ 2 Pts for the number ± 8;\n+ 1 Pts for the number ± 16;\n+ 0 Pts & -1 Life otherwise;",
                          style: TextStyle(fontFamily: "VT323"),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Center(
              child: ElevatedButton(
                onPressed: (() => _start()),
                child: const Text("START!"),
              ),
            ),
          ]);
    } else if (_currentLife == 0 || _endOfGame) {
      child = Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          title: Text(
            "Leaderboard:",
            style: Costants.coloredTextStyle(context, Colors.black,
                Theme.of(context).textTheme.headlineSmall!),
            textAlign: TextAlign.left,
          ),
        ),
        FutureBuilder(
          future: _leaderboard.getLeaderboardTable(context),
          builder: ((context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (!snapshot.hasData) return const CircularProgressIndicator();

            return Padding(
              padding: const EdgeInsets.all(5),
              child: Table(
                border: TableBorder.all(borderRadius: BorderRadius.circular(8)),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: snapshot.data!,
              ),
            );
          }),
        ),
        const Divider(),
        ListTile(
          title: const Text("You final score is:"),
          trailing: Text("$_currentScore"),
        ),
        Form(
            key: _leaderboardFormKey,
            child: Column(
              children: [
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: _leaderboardInputTextController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: "Insert username for submission here."),
                    maxLength: 20,
                    maxLengthEnforcement:
                        MaxLengthEnforcement.truncateAfterCompositionEnds,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    }),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() => _submit()),
                  child: const Text("Submit result!"),
                ),
              ],
            )),
        const Divider(),
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
                      if (ival < widget.rangeStart || ival > widget.rangeEnd) {
                        return 'Value must be between ${widget.rangeStart} and ${widget.rangeEnd}.';
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
