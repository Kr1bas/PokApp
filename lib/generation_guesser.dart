import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokapp/constants.dart';
import 'package:pokapp/parallax_scrolling.dart';
import 'dart:math';
import 'package:pokapp/leaderbord.dart';

class GenerationGuesserHomePage extends StatelessWidget {
  const GenerationGuesserHomePage({super.key, required this.gameID});
  final String gameID;

  List<DisplayPageItem> getGenerationGuesserPageList() {
    final widgets = <DisplayPageItem>[];
    widgets.add(DisplayPageItem(
      navigateTo: GenerationGuesserGamePage(
        categoryID: 'all',
        gameID: gameID,
      ),
      title: "Every Generation!",
      subTitle: "Only every pokemon ever made!",
      assetImage: "assets/images/other/pk_wp_3.jpg",
    ));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PokAPP Generation Guess"),
      ),
      body: Center(
        child: SafeArea(
          child: ListView(children: getGenerationGuesserPageList()),
        ),
      ),
    );
  }
}

class GenerationGuesserGamePage extends StatefulWidget {
  const GenerationGuesserGamePage(
      {super.key, required this.gameID, required this.categoryID});
  final String gameID;
  final String categoryID;
  @override
  State<GenerationGuesserGamePage> createState() =>
      _GenerationGuesserGamePageState();
}

class _GenerationGuesserGamePageState extends State<GenerationGuesserGamePage> {
  int _currentScore = 0;
  int _currentPick = -1;
  int _currentLife = -1;
  final List<int> _alreadyExtracted = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _inputTextController = TextEditingController();
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();
  }

  void _start() async {
    //TEST
    try {
      final ldb = await Leaderboard.getLeaderboard(
        game: widget.gameID,
        category: widget.categoryID,
      );
      print(ldb.toString());
    } catch (e) {
      print(e.toString());
    }

    //ENDTEST

    _currentLife = 3;
    _currentPick = _rng.nextInt(kalosEnd) + kantoStart;
    _alreadyExtracted.add(_currentPick);
    setState(() {});
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

  bool _isCorrectGeneration(int guess, int extracted) {
    return guess == _generation(extracted);
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      if (_isCorrectGeneration(
          int.parse(_inputTextController.text), _currentPick)) {
        _currentScore += 1;
        do {
          _currentPick = _rng.nextInt(absoluteEnd) + absoluteStart;
        } while (_alreadyExtracted.contains(_currentPick));
        _alreadyExtracted.add(_currentPick);
      } else {
        _currentLife -= 1;
      }
      _formKey.currentState!.reset();
    }
  }

  void _restart() {
    setState(() {
      // TODO finish
      _formKey.currentState!.reset();
      _currentLife = 3;
      _alreadyExtracted.removeWhere((e) => true);
      _currentPick = -1;
    });
  }

  List<Widget> _getCurrentLifeIcons() {
    List<Widget> icons = [];
    for (var i = 0; i < _currentLife; i++) {
      icons.add(const Icon(
        Icons.favorite,
        color: Colors.red,
      ));
    }
    for (var i = 0; i < (3 - _currentLife); i++) {
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
      child = ElevatedButton(
        onPressed: (() => _start()),
        child: const Text("START!"),
      );
    } else if (_currentLife == 0) {
      child = Padding(
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 100),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset.zero,
                  blurRadius: 4,
                  spreadRadius: 2,
                  blurStyle: BlurStyle.normal)
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            ListTile(
              title: const Text("You final score is:"),
              trailing: Text("$_currentScore"),
            ),
            /* FutureBuilder(
                future: _getCurrentLeaderboard(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                        'Error retrieving the leaderboard:\n${snapshot.error.toString()}');
                  }
                  if (!snapshot.hasData) return const LinearProgressIndicator();
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: snapshot.data!,
                    ),
                  );
                })), */
            ElevatedButton(
              onPressed: (() => _restart()),
              child: const Text("RESTART!"),
            )
          ]),
        ),
      );
    } else {
      child = AspectRatio(
        aspectRatio: 3 / 4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset.zero,
                    blurRadius: 4,
                    spreadRadius: 2,
                    blurStyle: BlurStyle.normal)
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                        hintText: "Insert Generation here"),
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    maxLength: 1,
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
            ]),
          ),
        ),
      );
    }
    return Stack(
      children: <Widget>[
        Image.asset("assets/images/other/pk_wp_2.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("PokAPP"),
          ),
          body: Center(child: child),
        )
      ],
    );
  }
}
