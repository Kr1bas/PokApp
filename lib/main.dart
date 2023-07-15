import 'dart:js';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokAPP',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void goToNumberGuesser(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const NumberGuesser())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PokAPP"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: (() => goToNumberGuesser(context)),
                child: const Text("NumberGuesser"))
          ],
        ),
      ),
    );
  }
}

class NumberGuesser extends StatefulWidget {
  const NumberGuesser({super.key});

  @override
  State<NumberGuesser> createState() => _NumberGuesserState();
}

class _NumberGuesserState extends State<NumberGuesser> {
  int currentScore = 0;
  int maxScore = 0;
  int currentPick = -1;
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  void next() {
    currentPick = _rng.nextInt(151) + 1;
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
          "assets/images/${currentPick < 10 ? '00$currentPick' : (currentPick < 100 ? '0$currentPick' : '$currentPick')}.png",
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
