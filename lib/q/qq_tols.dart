import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum GuessAnswer {
  wrong,
  draw,
  right;

  String get displayName {
    switch (this) {
      case GuessAnswer.wrong:
        return "Wrong";
      case GuessAnswer.draw:
        return "50-50";
      case GuessAnswer.right:
        return "Right";
    }
  }
}

class GuessModl {
  final int guessModlid;
  final GuessAnswer? guessAnswer;
  final DateTime guessModlDate;
  final String guessModlName;

  GuessModl(
      {required this.guessModlid,
      required this.guessModlDate,
      required this.guessModlName,
      this.guessAnswer});

  Map<String, dynamic> toMap() {
    return {
      'guessModlid': guessModlid,
      'guessAnswer': guessAnswer?.name,
      'guessModlDate': guessModlDate.toIso8601String(),
      'guessModlName': guessModlName,
    };
  }

  factory GuessModl.fromMap(Map<String, dynamic> map) {
    return GuessModl(
      guessModlid: map['guessModlid'],
      guessAnswer: map['guessAnswer'] != null
          ? GuessAnswer.values.firstWhere((e) => e.name == map['guessAnswer'])
          : null,
      guessModlDate: DateTime.parse(map['guessModlDate']),
      guessModlName: map['guessModlName'],
    );
  }
  GuessModl copyWith(
      {int? guessModlid,
      ValueGetter<GuessAnswer?>? guessAnswer,
      DateTime? guessModlDate,
      String? guessModlName}) {
    return GuessModl(
        guessModlid: guessModlid ?? this.guessModlid,
        guessAnswer: guessAnswer != null ? guessAnswer() : this.guessAnswer,
        guessModlDate: guessModlDate ?? this.guessModlDate,
        guessModlName: guessModlName ?? this.guessModlName);
  }
}

class GuesssModlProvider with ChangeNotifier {
  List<GuessModl> _guessModls = [];
  static const String _storageKey = 'guessModlsData';

  List<GuessModl> get guessModls => _guessModls;

  GuesssModlProvider() {
    loadData();
  }
  List<GuessModl> getGuesModlActive() {
    return _guessModls.where((modl) => modl.guessAnswer == null).toList()
      ..sort((a, b) => a.guessModlDate.compareTo(b.guessModlDate));
  }

  List<GuessModl> getGuesModlHistory() {
    return _guessModls.where((modl) => modl.guessAnswer != null).toList()
      ..sort((a, b) => b.guessModlDate.compareTo(a.guessModlDate));
  }

  Future<void> addUpdateGuessModl(GuessModl modl) async {
    final index =
        _guessModls.indexWhere((m) => m.guessModlid == modl.guessModlid);
    if (index >= 0) {
      _guessModls[index] = modl;
    } else {
      _guessModls.add(modl);
    }
    await saveData();
    notifyListeners();
  }

  Future<void> saveData() async {
    final llkdns5 = await SharedPreferences.getInstance();
    final modlsJjsjs = _guessModls.map((modl) => modl.toMap()).toList();
    await llkdns5.setString(_storageKey, jsonEncode(modlsJjsjs));
  }

  Future<void> loadData() async {
    final llkdns5 = await SharedPreferences.getInstance();
    final modlsJjsjs = llkdns5.getString(_storageKey);
    if (modlsJjsjs != null) {
      final List<dynamic> decoded = jsonDecode(modlsJjsjs);
      _guessModls = decoded.map((modl) => GuessModl.fromMap(modl)).toList();
      notifyListeners();
    }
  }
}
