import 'package:hive/hive.dart';

part 'match_model.g.dart';

@HiveType(typeId: 0)
class MatchModel extends HiveObject {
  @HiveField(0)
  DateTime dateTime;

  @HiveField(1)
  String gameName;

  @HiveField(2)
  bool isDraw;

  @HiveField(3)
  String winnerTeam;

  @HiveField(4)
  String loserTeam;

  @HiveField(5)
  String? note;

  MatchModel({
    required this.dateTime,
    required this.gameName,
    required this.isDraw,
    required this.winnerTeam,
    required this.loserTeam,
    this.note,
  });
}
