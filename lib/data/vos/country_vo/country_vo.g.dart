// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryVOAdapter extends TypeAdapter<CountryVO> {
  @override
  final int typeId = 5;

  @override
  CountryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryVO(
      country: fields[0] as String?,
      slug: fields[1] as String?,
      iso2: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CountryVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.country)
      ..writeByte(1)
      ..write(obj.slug)
      ..writeByte(2)
      ..write(obj.iso2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryVO _$CountryVOFromJson(Map<String, dynamic> json) => CountryVO(
      country: json['Country'] as String?,
      slug: json['Slug'] as String?,
      iso2: json['ISO2'] as String?,
    );

Map<String, dynamic> _$CountryVOToJson(CountryVO instance) => <String, dynamic>{
      'Country': instance.country,
      'Slug': instance.slug,
      'ISO2': instance.iso2,
    };
