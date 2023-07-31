import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokapp/constants.dart';

class Leaderboard {
  final String game;
  final String category;
  final List<LeaderboardMember> leaderboardMembers;

  const Leaderboard({
    required this.game,
    required this.category,
    required this.leaderboardMembers,
  });

  static Future<Leaderboard> getLeaderboard({
    required String game,
    required String category,
  }) async {
    final db = FirebaseFirestore.instance;
    final res = await db
        .collection('leaderboards')
        .doc(game)
        .collection(category)
        .orderBy('score', descending: true)
        .limit(10)
        .withConverter(
            fromFirestore: LeaderboardMember.fromFirebase,
            toFirestore: (e, _) => e.toFirestore())
        .get();

    return Leaderboard(
      game: game,
      category: category,
      leaderboardMembers: res.docs.map((e) => e.data()).toList(),
    );
  }

  Future<List<TableRow>> getLeaderboardTable(BuildContext context) async {
    List<TableRow> rows = [
      TableRow(children: [
        TableCell(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
              color: Colors.red,
            ),
            child: Text(
              '#',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        TableCell(
          child: Container(
            color: Colors.red,
            child: Text(
              'Username',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        TableCell(
          child: Container(
            color: Colors.red,
            child: Text(
              'Timestamp',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        TableCell(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
              color: Colors.red,
            ),
            child: Text(
              'Score',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        )
      ]),
    ];
    rows.addAll(leaderboardMembers.map(
      (e) => TableRow(children: [
        TableCell(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Text(
                '${leaderboardMembers.indexOf(e) + 1}',
                style: Costants.coloredTextStyle(
                    context,
                    leaderboardMembers.indexOf(e) == 0
                        ? Colors.yellow
                        : leaderboardMembers.indexOf(e) == 1
                            ? Colors.grey
                            : leaderboardMembers.indexOf(e) == 2
                                ? Colors.brown
                                : Colors.white,
                    Theme.of(context).textTheme.headlineSmall!),
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            color: Colors.white,
            child: Text(
              e.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        TableCell(
          child: Container(
            color: Colors.white,
            child: Text(
              e.timestamp
                  .toDate()
                  .toIso8601String()
                  .replaceAll('T', ' ')
                  .split('.')[0],
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        TableCell(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Text(
                '${e.score}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        )
      ]),
    ));
    return rows;
  }

  void uploadScoreToLeaderboard(
      {required String username, required int score, Timestamp? timestamp}) {
    //todo implement
  }
}

class LeaderboardMember {
  final String name;
  final int score;
  final Timestamp timestamp;

  const LeaderboardMember({
    required this.name,
    required this.score,
    required this.timestamp,
  });

  factory LeaderboardMember.fromFirebase(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    //final data = snapshot.data();
    print(
        "|${snapshot.id}|${snapshot.get('score')}|${snapshot.get('timestamp')}|");
    return LeaderboardMember(
        name: snapshot.id,
        score: snapshot.get('score'),
        timestamp: snapshot.get('timestamp'));
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'score': score,
      'timestamp': timestamp,
    };
  }
}
