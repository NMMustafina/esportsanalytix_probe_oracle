import 'package:hive/hive.dart';

part 'player_model.g.dart';

@HiveType(typeId: 1)
class PlayerModel extends HiveObject {
  @HiveField(0)
  String avatarPath;

  @HiveField(1)
  String nickname;

  @HiveField(2)
  String game;

  @HiveField(3)
  String mainRole;

  @HiveField(4)
  int rating;

  @HiveField(5)
  String favoriteItems;

  @HiveField(6)
  int matchCount;

  @HiveField(7)
  double winRate;

  @HiveField(8)
  double avgKDA;

  PlayerModel({
    required this.avatarPath,
    required this.nickname,
    required this.game,
    required this.mainRole,
    required this.rating,
    required this.favoriteItems,
    required this.matchCount,
    required this.winRate,
    required this.avgKDA,
  });
}
