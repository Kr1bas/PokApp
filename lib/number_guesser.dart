import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokapp/parallax_scrolling.dart';
import 'dart:math';

class NumberGuesserHomePage extends StatelessWidget {
  const NumberGuesserHomePage({super.key});

  List<DisplayPageItem> getNumberGuesserPageList() {
    final widgets = <DisplayPageItem>[];
    widgets.add(DisplayPageItem(
      navigateTo: const NumberGuesserGamePage(min: 1, max: 151),
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
  const NumberGuesserGamePage(
      {super.key, required this.max, required this.min});

  final int max;
  final int min;
  @override
  State<NumberGuesserGamePage> createState() => _NumberGuesserGamePageState();
}

class _NumberGuesserGamePageState extends State<NumberGuesserGamePage> {
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

  void _start() {
    _currentLife = 3;
    _currentPick = _rng.nextInt(widget.max - 1) + widget.min;
    _alreadyExtracted.add(_currentPick);
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      if (int.parse(_inputTextController.text) == _currentPick) {
        _currentScore += 1;
        do {
          _currentPick = _rng.nextInt(widget.max - 1) + widget.min;
        } while (_alreadyExtracted.contains(_currentPick));
      } else {
        _currentLife -= 1;
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
        onPressed: (() => setState(() => _start())),
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
            ElevatedButton(
              onPressed: (() => setState(() => _start())),
              child: const Text("RESTART!"),
            )
          ]),
        ),
      );
    } else {
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Current Score: $_currentScore"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getCurrentLifeIcons(),
            ),
            Image.asset(
              "assets/images/dex/${_currentPick < 10 ? '00$_currentPick' : (_currentPick < 100 ? '0$_currentPick' : '$_currentPick')}.png",
              fit: BoxFit.contain,
            ),
            Form(
              key: _formKey,
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  controller: _inputTextController,
                  decoration:
                      const InputDecoration(hintText: "Insert number here"),
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  maxLength: 4,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    if (int.parse(value) < widget.min ||
                        int.parse(value) > widget.max) {
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
          ]),
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
