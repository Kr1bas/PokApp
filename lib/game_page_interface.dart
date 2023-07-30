import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokapp/constants.dart';
import 'package:pokapp/parallax_scrolling.dart';
import 'dart:math';
import 'package:pokapp/leaderbord.dart';

abstract class GameHomePage extends StatelessWidget {
  const GameHomePage({super.key, required this.gameID, required this.title});
  final String gameID;
  final String title;

  List<DisplayPageItem> getGamePageList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: SafeArea(
          child: ListView(children: getGamePageList()),
        ),
      ),
    );
  }
}

class GamePageScaffold extends StatefulWidget {
  const GamePageScaffold({super.key, required this.title, required this.child});

  final String title;
  final Widget child;
  @override
  State<GamePageScaffold> createState() => _GamePageScaffoldState();
}

class _GamePageScaffoldState extends State<GamePageScaffold> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset("assets/images/other/pk_wp_2.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: AspectRatio(
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
                    child: widget.child),
              ),
            ),
          ),
        )
      ],
    );
  }
}
