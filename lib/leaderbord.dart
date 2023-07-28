import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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
}

class LeaderboardMember {
  final String name;
  final String score;
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
