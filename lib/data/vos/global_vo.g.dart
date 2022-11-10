// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GlobalVOAdapter extends TypeAdapter<GlobalVO> {
  @override
  final int typeId = 1;

  @override
  GlobalVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlobalVO(
      newConfirmed: fields[0] as int?,
      totalConfirmed: fields[1] as int?,
      newDeaths: fields[2] as int?,
      totalDeaths: fields[3] as int?,
      newRecovered: fields[4] as int?,
      totalRecovered: fields[5] as int?,
      date: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GlobalVO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.newConfirmed)
      ..writeByte(1)
      ..write(obj.totalConfirmed)
      ..writeByte(2)
      ..write(obj.newDeaths)
      ..writeByte(3)
      ..write(obj.totalDeaths)
      ..writeByte(4)
      ..write(obj.newRecovered)
      ..writeByte(5)
      ..write(obj.totalRecovered)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalVO _$GlobalVOFromJson(Map<String, dynamic> json) => GlobalVO(
      newConfirmed: json['NewConfirmed'] as int?,
      totalConfirmed: json['TotalConfirmed'] as int?,
      newDeaths: json['NewDeaths'] as int?,
      totalDeaths: json['TotalDeaths'] as int?,
      newRecovered: json['NewRecovered'] as int?,
      totalRecovered: json['TotalRecovered'] as int?,
      date: json['Date'] as String?,
    );

Map<String, dynamic> _$GlobalVOToJson(GlobalVO instance) => <String, dynamic>{
      'NewConfirmed': instance.newConfirmed,
      'TotalConfirmed': instance.totalConfirmed,
      'NewDeaths': instance.newDeaths,
      'TotalDeaths': instance.totalDeaths,
      'NewRecovered': instance.newRecovered,
      'TotalRecovered': instance.totalRecovered,
      'Date': instance.date,
    };
