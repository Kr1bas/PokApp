import 'package:flutter/material.dart';
import 'package:pokapp/generation_guesser.dart';

import 'package:pokapp/constants.dart';
import 'package:pokapp/parallax_scrolling.dart';
import 'package:pokapp/number_guesser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

  List<DisplayPageItem> getHomePageList() {
    final widgets = <DisplayPageItem>[];
    widgets.add(DisplayPageItem(
      navigateTo: const NumberGuesserHomePage(),
      title: "Number Guesser",
      subTitle: "Guess the pokedex number",
      assetImage: "assets/images/other/pkdex_guess.png",
    ));
    widgets.add(DisplayPageItem(
      navigateTo: const GenerationGuesserHomePage(
        gameID: generationGuesserID,
        title: "PokAPP Generation Guesser",
      ),
      title: "Generation Guesser",
      subTitle: "Guess from which generation the pokemon is.",
      assetImage: "assets/images/other/pkdex.png",
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
          child: ListView(children: getHomePageList()),
        ),
      ),
    );
  }
}
