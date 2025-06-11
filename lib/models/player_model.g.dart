// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerModelAdapter extends TypeAdapter<PlayerModel> {
  @override
  final int typeId = 1;

  @override
  PlayerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerModel(
      avatarPath: fields[0] as String,
      nickname: fields[1] as String,
      game: fields[2] as String,
      mainRole: fields[3] as String,
      rating: fields[4] as int,
      favoriteItems: fields[5] as String,
      matchCount: fields[6] as int,
      winRate: fields[7] as double,
      avgKDA: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.avatarPath)
      ..writeByte(1)
      ..write(obj.nickname)
      ..writeByte(2)
      ..write(obj.game)
      ..writeByte(3)
      ..write(obj.mainRole)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.favoriteItems)
      ..writeByte(6)
      ..write(obj.matchCount)
      ..writeByte(7)
      ..write(obj.winRate)
      ..writeByte(8)
      ..write(obj.avgKDA);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
