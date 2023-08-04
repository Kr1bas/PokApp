import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokapp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokapp/game_page_interface.dart';
import 'package:pokapp/leaderbord.dart';
import 'package:pokapp/parallax_scrolling.dart';
import 'package:pokapp/pokedex_handler.dart';

class NameGuesserHomePage extends GameHomePage {
  const NameGuesserHomePage(
      {super.key, required super.gameID, required super.title});

  @override
  List<DisplayPageItem> getGamePageList() {
    final widgets = <DisplayPageItem>[];
    widgets.add(DisplayPageItem(
      navigateTo: NameGuesserGamePage(
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
        navigateTo: NameGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryJhoto,
            rangeStart: Costants.jhotoStart,
            rangeEnd: Costants.jhotoEnd,
            title: title),
        title: "Second Generation",
        subTitle: "Only Pokemons from the Jhoto region!",
        assetImage: "assets/images/covers/pk_hgss.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NameGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryHoenn,
            rangeStart: Costants.hoennStart,
            rangeEnd: Costants.hoennEnd,
            title: title),
        title: "Third Generation",
        subTitle: "Only Pokemons from the Hoenn region!",
        assetImage: "assets/images/covers/pk_rs.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NameGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categorySinnoh,
            rangeStart: Costants.sinnohStart,
            rangeEnd: Costants.sinnohEnd,
            title: title),
        title: "Fourth Generation",
        subTitle: "Only Pokemons from the Sinnoh region!",
        assetImage: "assets/images/covers/pk_dp.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NameGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryUnova,
            rangeStart: Costants.unovaStart,
            rangeEnd: Costants.unovaEnd,
            title: title),
        title: "Fifth Generation",
        subTitle: "Only Pokemons from the Unima/Unova region!",
        assetImage: "assets/images/covers/pk_bw.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NameGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryKalos,
            rangeStart: Costants.kalosStart,
            rangeEnd: Costants.kalosEnd,
            title: title),
        title: "Sixth Generation",
        subTitle: "Only Pokemons from the Kalos region!",
        assetImage: "assets/images/covers/pk_xy.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NameGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryAlola,
            rangeStart: Costants.alolaStart,
            rangeEnd: Costants.alolaEnd,
            title: title),
        title: "Seventh Generation",
        subTitle: "Only Pokemons from the Alola region!",
        assetImage: "assets/images/covers/pk_usum.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NameGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryGalar,
            rangeStart: Costants.galarStart,
            rangeEnd: Costants.galarEnd,
            title: title),
        title: "Eighth Generation",
        subTitle: "Only Pokemons from the Galar/Isui region!",
        assetImage: "assets/images/covers/pk_ss.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NameGuesserGamePage(
            gameID: gameID,
            categoryID: Costants.categoryPaldea,
            rangeStart: Costants.paldeaStart,
            rangeEnd: Costants.paldeaEnd,
            title: title),
        title: "Nineth Generation",
        subTitle: "Only Pokemons from the Paldea region!",
        assetImage: "assets/images/covers/pk_sv.jpg"));
    widgets.add(DisplayPageItem(
        navigateTo: NameGuesserGamePage(
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

class NameGuesserGamePage extends StatefulWidget {
  const NameGuesserGamePage(
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
  State<NameGuesserGamePage> createState() => _NameGuesserGamePageState();
}

class _NameGuesserGamePageState extends State<NameGuesserGamePage> {
  int _currentScore = 0;
  int _currentPick = -1;
  int _currentLife = -1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _leaderboardFormKey = GlobalKey<FormState>();
  String _selectedAnswer = "";
  final _leaderboardInputTextController = TextEditingController();
  bool _leaderboardSubmitted = false;
  final Random _rng = Random();
  late final Leaderboard _leaderboard;
  int _scoreDelta = 0;
  int _lifeDelta = 0;
  Widget _correctMessage = const Text("");
  bool _endOfGame = false;
  late final PokedexHandler _pokedex;
  final List<int> _validIndexes = [];

  @override
  void initState() {
    Leaderboard.getLeaderboard(game: widget.gameID, category: widget.categoryID)
        .then((value) {
      _leaderboard = value;
    });
    _pokedex = PokedexHandler(
      rangeStart: widget.rangeStart,
      rangeEnd: widget.rangeEnd,
    );
    super.initState();
  }

  void _submit() {
    if (_leaderboardFormKey.currentState!.validate()) {
      _leaderboard
          .uploadScoreToLeaderboard(
            score: LeaderboardMember(
                name: _leaderboardInputTextController.text,
                score: _currentScore,
                timestamp: Timestamp.now()),
          )
          .then(
              ((value) => _leaderboard.updateLeaderboardMembers().then((value) {
                    _leaderboardSubmitted = true;
                    setState(() {});
                  })));
    }
  }

  bool _isCorrectAnswer({required String answer, required int currentPick}) {
    return _pokedex.isCorrectName(answer, currentPick);
  }

  void _start() async {
    _endOfGame = false;
    _validIndexes.addAll([
      for (var i = widget.rangeStart; i <= widget.rangeEnd; i++) i
    ].where((element) => !_validIndexes.contains(element)));
    _currentLife = widget.maxLives;
    _currentPick = _validIndexes[_rng.nextInt(_validIndexes.length)];
    _validIndexes.remove(_currentPick);
    setState(() {});
  }

  void _next() {
    _scoreDelta = 0;
    _lifeDelta = 0;
    if (_selectedAnswer.trim() != "") {
      if (_isCorrectAnswer(
          answer: _selectedAnswer, currentPick: _currentPick)) {
        _currentScore += 1;
        _scoreDelta = 1;
        _correctMessage = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Correct! Pokémon"),
            SizedBox(
              width: 30,
              child: Image.asset(
                "assets/images/dex/${_currentPick < 10 ? '00$_currentPick' : (_currentPick < 100 ? '0$_currentPick' : '$_currentPick')}.png",
                fit: BoxFit.contain,
              ),
            ),
            Text("is: $_selectedAnswer"),
          ],
        );
        if (_validIndexes.isEmpty) {
          _endOfGame = true;
        }
        if (!_endOfGame) {
          _currentPick =
              _currentPick = _validIndexes[_rng.nextInt(_validIndexes.length)];
          _validIndexes.remove(_currentPick);
        }
      } else {
        _correctMessage = const Text(
          "Wrong! Try again.",
          style: TextStyle(color: Colors.red),
        );
        _currentLife -= 1;
        _lifeDelta = -1;
      }
      _formKey.currentState!.reset();
      _selectedAnswer = "";
    } else {
      _correctMessage = const Text(
        "Please enter a name.",
        style: TextStyle(color: Colors.red),
      );
    }
  }

  void _restart() {
    _leaderboardSubmitted = false;
    _formKey.currentState?.reset();
    _currentLife = widget.maxLives;
    _currentScore = 0;
    _scoreDelta = 0;
    _lifeDelta = 0;
    _correctMessage = const Text("");
    _start();
  }

  List<Widget> _getCurrentLifeIcons() {
    List<Widget> icons = [];
    for (var i = 0; i < _currentLife; i++) {
      icons.add(const Icon(
        Icons.favorite,
        color: Colors.red,
      ));
    }
    for (var i = 0; i < (Costants.maxLives - _currentLife); i++) {
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
                    width: 400, height: 120, fit: BoxFit.fill),
                const SizedBox(
                  width: 370,
                  child: AspectRatio(
                    aspectRatio: 4 / 1.2,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 23, top: 2),
                        child: Text(
                          "You have to guess the name of the \"shown\" Pokémon.\nScoring goes as follows:\n+ 1 Pts for the correct name;\n+ 0 Pts & -1 Life otherwise;",
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
                    autofocus: true,
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
                      if (_leaderboardSubmitted) {
                        return "Score already submitted";
                      }
                      if ((_leaderboard.getMemberByUser(value)?.score ?? -1) >
                          _currentScore) {
                        return "User $value already has an higher score.";
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
              child: ImageIcon(
                Image.asset(
                  "assets/images/dex/${_currentPick < 10 ? '00$_currentPick' : (_currentPick < 100 ? '0$_currentPick' : '$_currentPick')}.png",
                  fit: BoxFit.contain,
                ).image,
                size: MediaQuery.of(context).size.height / 10,
              ),
            ),
            Form(
              key: _formKey,
              child: SizedBox(
                width: 250,
                child: Autocomplete<String>(
                  optionsMaxHeight: 50,
                  optionsBuilder: ((textEditingValue) {
                    return _pokedex.getNamesList().where((String option) {
                      return option
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  }),
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4.0,
                        child: SizedBox(
                          width: 250,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8.0),
                            itemCount: options.length,
                            separatorBuilder: (context, i) {
                              return const Divider();
                            },
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () =>
                                    onSelected(options.elementAt(index)),
                                title: Text(options.elementAt(index)),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: (option) {
                    _selectedAnswer = option;
                  },
                ),
              ),
            ),
            _correctMessage,
            ElevatedButton(
                onPressed: () => setState(() => _next()),
                child: const Text("Next!")),
          ]);
    }
    return GamePageScaffold(title: widget.title, child: child);
  }
}
