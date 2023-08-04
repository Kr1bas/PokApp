import 'package:cloud_firestore/cloud_firestore.dart';
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
      navigateTo: GenerationGuesserGamePage(
        categoryID: Costants.categoryAll,
        gameID: gameID,
        title: title,
        rangeEnd: Costants.absoluteEnd,
        rangeStart: Costants.absoluteStart,
        maxLives: 3,
        inputMaxLength: 1,
      ),
      title: "Every Generation!",
      subTitle: "Only every pokemon ever made!",
      assetImage: "assets/images/other/pk_wp_3.jpg",
    ));
    widgets.add(DisplayPageItem(
      navigateTo: GenerationGuesserShadowGamePage(
        categoryID: Costants.categoryShadow,
        gameID: gameID,
        title: title,
        rangeEnd: Costants.absoluteEnd,
        rangeStart: Costants.absoluteStart,
        maxLives: 3,
        inputMaxLength: 1,
      ),
      title: "Shadow!",
      subTitle: "Every pokemon ever made, but with a twist!",
      assetImage: "assets/images/other/pk_who.jpg",
    ));
    return widgets;
  }
}

class GenerationGuesserGamePage extends StatefulWidget {
  const GenerationGuesserGamePage({
    super.key,
    required this.title,
    required this.gameID,
    required this.categoryID,
    required this.rangeEnd,
    required this.rangeStart,
    this.maxLives = Costants.maxLives,
    required this.inputMaxLength,
  });
  final String title;
  final String gameID;
  final String categoryID;
  final int rangeStart;
  final int rangeEnd;
  final int maxLives;
  final int inputMaxLength;
  @override
  State<GenerationGuesserGamePage> createState() =>
      _GenerationGuesserGamePageState();
}

class _GenerationGuesserGamePageState extends State<GenerationGuesserGamePage> {
  int _currentScore = 0;
  int _currentPick = -1;
  int _currentLife = -1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _leaderboardFormKey = GlobalKey<FormState>();
  final _inputTextController = TextEditingController();
  final _leaderboardInputTextController = TextEditingController();
  bool _leaderboardSubmitted = false;
  final Random _rng = Random();
  late final Leaderboard _leaderboard;
  int _scoreDelta = 0;
  int _lifeDelta = 0;
  bool _endOfGame = false;
  final List<int> _validIndexes = [];

  int _generation(int index) {
    if (index <= Costants.kantoEnd) return 1;
    if (index <= Costants.jhotoEnd) return 2;
    if (index <= Costants.hoennEnd) return 3;
    if (index <= Costants.sinnohEnd) return 4;
    if (index <= Costants.unovaEnd) return 5;
    if (index <= Costants.kalosEnd) return 6;
    if (index <= Costants.alolaEnd) return 7;
    if (index <= Costants.galarEnd) return 8;
    if (index <= Costants.paldeaEnd) return 9;
    return -1;
  }

  bool _isCorrectAnswer({required String answer, required int currentPick}) {
    return int.parse(answer) == _generation(currentPick);
  }

  @override
  void initState() {
    Leaderboard.getLeaderboard(game: widget.gameID, category: widget.categoryID)
        .then((value) {
      _leaderboard = value;
    });
    super.initState();
  }

  void _start() {
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
    if (_formKey.currentState!.validate()) {
      if (_isCorrectAnswer(
          answer: _inputTextController.text, currentPick: _currentPick)) {
        _currentScore += 1;
        _scoreDelta = 1;
        if (_validIndexes.isEmpty) {
          _endOfGame = true;
        }
        if (!_endOfGame) {
          _currentPick =
              _currentPick = _validIndexes[_rng.nextInt(_validIndexes.length)];
          _validIndexes.remove(_currentPick);
        }
      } else {
        _currentLife -= 1;
        _lifeDelta = -1;
      }
      _formKey.currentState!.reset();
    }
  }

  void _restart() {
    _leaderboardSubmitted = false;
    _formKey.currentState?.reset();
    _currentLife = widget.maxLives;
    _currentScore = 0;
    _scoreDelta = 0;
    _lifeDelta = 0;
    _start();
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
                          "You have to guess the Generation in which the shown Pokémon was released.\nScoring goes as follows:\n+ 1 Pts for the correct number;\n+ 0 Pts & -1 Life otherwise;",
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
                  autofocus: true,
                  controller: _inputTextController,
                  decoration:
                      const InputDecoration(hintText: "Insert Generation here"),
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  maxLength: widget.inputMaxLength,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    int ival = int.parse(value);
                    if (ival < 1 || ival > 9) {
                      return 'Value must be between 1 and 9.';
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

class GenerationGuesserShadowGamePage extends StatefulWidget {
  const GenerationGuesserShadowGamePage({
    super.key,
    required this.title,
    required this.gameID,
    required this.categoryID,
    required this.rangeEnd,
    required this.rangeStart,
    required this.maxLives,
    required this.inputMaxLength,
  });
  final String title;
  final String gameID;
  final String categoryID;
  final int rangeStart;
  final int rangeEnd;
  final int maxLives;
  final int inputMaxLength;
  @override
  State<GenerationGuesserShadowGamePage> createState() =>
      _GenerationGuesserShadowGamePageState();
}

class _GenerationGuesserShadowGamePageState
    extends State<GenerationGuesserShadowGamePage> {
  int _currentScore = 0;
  int _currentPick = -1;
  int _currentLife = -1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _leaderboardFormKey = GlobalKey<FormState>();
  final _inputTextController = TextEditingController();
  final _leaderboardInputTextController = TextEditingController();
  bool _leaderboardSubmitted = false;
  final Random _rng = Random();
  late final Leaderboard _leaderboard;
  int _scoreDelta = 0;
  int _lifeDelta = 0;
  Widget _correctMessage = const Text("");
  bool _endOfGame = false;
  final List<int> _validIndexes = [];

  @override
  void initState() {
    Leaderboard.getLeaderboard(game: widget.gameID, category: widget.categoryID)
        .then((value) {
      _leaderboard = value;
    });

    super.initState();
  }

  int _generation(int index) {
    if (index <= Costants.kantoEnd) return 1;
    if (index <= Costants.jhotoEnd) return 2;
    if (index <= Costants.hoennEnd) return 3;
    if (index <= Costants.sinnohEnd) return 4;
    if (index <= Costants.unovaEnd) return 5;
    if (index <= Costants.kalosEnd) return 6;
    if (index <= Costants.alolaEnd) return 7;
    if (index <= Costants.galarEnd) return 8;
    if (index <= Costants.paldeaEnd) return 9;
    return -1;
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
    return int.parse(answer) == _generation(currentPick);
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
    if (_formKey.currentState!.validate()) {
      if (_isCorrectAnswer(
          answer: _inputTextController.text, currentPick: _currentPick)) {
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
            Text("is from generation: ${_inputTextController.text}"),
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
        _currentLife -= 1;
        _lifeDelta = -1;
      }
      _formKey.currentState!.reset();
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
                          "You have to guess the Generation in which the \"shown\" Pokémon was released.\nScoring goes as follows:\n+ 1 Pts for the correct number;\n+ 0 Pts & -1 Life otherwise;",
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
                child: TextFormField(
                  autofocus: true,
                  controller: _inputTextController,
                  decoration:
                      const InputDecoration(hintText: "Insert Generation here"),
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  maxLength: widget.inputMaxLength,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    int ival = int.parse(value);
                    if (ival < 1 || ival > 9) {
                      return 'Value must be between 1 and 9.';
                    }
                    return null;
                  }),
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
