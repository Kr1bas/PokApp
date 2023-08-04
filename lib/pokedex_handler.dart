import 'dart:convert';

import 'package:flutter/services.dart';

class PokedexHandler {
  final int rangeStart;
  final int rangeEnd;
  final bool withStats;
  final bool withTypes;
  late final pokedexMap;

  PokedexHandler({
    required this.rangeStart,
    required this.rangeEnd,
    this.withStats = false,
    this.withTypes = false,
  }) {
    if (withStats) {
      if (withTypes) {
        rootBundle
            .loadString('assets/json/pokedex_with_stats_and_types.json')
            .then((value) {
          pokedexMap = jsonDecode(value);
        });
      } else {
        rootBundle
            .loadString('assets/json/pokedex_with_stats.json')
            .then((value) {
          pokedexMap = jsonDecode(value);
        });
      }
    } else {
      if (withTypes) {
        rootBundle
            .loadString('assets/json/pokedex_with_types.json')
            .then((value) {
          pokedexMap = jsonDecode(value);
        });
      }
    }
    rootBundle.loadString('assets/json/pokedex.json').then((value) {
      pokedexMap = jsonDecode(value);
    });
  }

  List<String> getNamesList() {
    List<String> list = [];
    for (var i = rangeStart; i <= rangeEnd; i++) {
      list.add((withStats || withTypes)
          ? pokedexMap['$i']['name']
          : pokedexMap['$i']);
    }
    return list;
  }

  String getNameByIndex(int index) {
    return (withStats || withTypes)
        ? pokedexMap['$index']['name']
        : pokedexMap['$index'];
  }

  bool isCorrectName(String answer, int extracted) {
    return ((withStats || withTypes)
            ? pokedexMap['$extracted']['name']
            : pokedexMap['$extracted']) ==
        answer;
  }
}
