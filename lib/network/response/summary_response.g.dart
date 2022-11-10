// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SummaryResponseAdapter extends TypeAdapter<SummaryResponse> {
  @override
  final int typeId = 4;

  @override
  SummaryResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SummaryResponse(
      id: fields[0] as String?,
      message: fields[1] as String?,
      global: fields[2] as GlobalVO?,
      countries: (fields[3] as List?)?.cast<SummaryCountryVO>(),
      date: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SummaryResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.global)
      ..writeByte(3)
      ..write(obj.countries)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SummaryResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryResponse _$SummaryResponseFromJson(Map<String, dynamic> json) =>
    SummaryResponse(
      id: json['ID'] as String?,
      message: json['Message'] as String?,
      global: json['Global'] == null
          ? null
          : GlobalVO.fromJson(json['Global'] as Map<String, dynamic>),
      countries: (json['Countries'] as List<dynamic>?)
          ?.map((e) => SummaryCountryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: json['Date'] as String?,
    );

Map<String, dynamic> _$SummaryResponseToJson(SummaryResponse instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Message': instance.message,
      'Global': instance.global,
      'Countries': instance.countries,
      'Date': instance.date,
    };
