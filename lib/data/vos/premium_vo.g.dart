// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PremiumVOAdapter extends TypeAdapter<PremiumVO> {
  @override
  final int typeId = 3;

  @override
  PremiumVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PremiumVO(
      name: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PremiumVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PremiumVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PremiumVO _$PremiumVOFromJson(Map<String, dynamic> json) => PremiumVO(
      name: json['premium'] as String?,
    );

Map<String, dynamic> _$PremiumVOToJson(PremiumVO instance) => <String, dynamic>{
      'premium': instance.name,
    };
