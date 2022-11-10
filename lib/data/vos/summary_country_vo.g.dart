// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_country_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SummaryCountryVOAdapter extends TypeAdapter<SummaryCountryVO> {
  @override
  final int typeId = 2;

  @override
  SummaryCountryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SummaryCountryVO(
      id: fields[0] as String?,
      country: fields[1] as String?,
      countryCode: fields[2] as String?,
      slug: fields[3] as String?,
      newConfirmed: fields[4] as int?,
      totalConfirmed: fields[5] as int?,
      newDeaths: fields[6] as int?,
      totalDeaths: fields[7] as int?,
      newRecovered: fields[8] as int?,
      totalRecovered: fields[9] as int?,
      date: fields[10] as String?,
      premium: fields[11] as PremiumVO?,
    );
  }

  @override
  void write(BinaryWriter writer, SummaryCountryVO obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.countryCode)
      ..writeByte(3)
      ..write(obj.slug)
      ..writeByte(4)
      ..write(obj.newConfirmed)
      ..writeByte(5)
      ..write(obj.totalConfirmed)
      ..writeByte(6)
      ..write(obj.newDeaths)
      ..writeByte(7)
      ..write(obj.totalDeaths)
      ..writeByte(8)
      ..write(obj.newRecovered)
      ..writeByte(9)
      ..write(obj.totalRecovered)
      ..writeByte(10)
      ..write(obj.date)
      ..writeByte(11)
      ..write(obj.premium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SummaryCountryVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryCountryVO _$SummaryCountryVOFromJson(Map<String, dynamic> json) =>
    SummaryCountryVO(
      id: json['ID'] as String?,
      country: json['Country'] as String?,
      countryCode: json['CountryCode'] as String?,
      slug: json['Slug'] as String?,
      newConfirmed: json['NewConfirmed'] as int?,
      totalConfirmed: json['TotalConfirmed'] as int?,
      newDeaths: json['NewDeaths'] as int?,
      totalDeaths: json['TotalDeaths'] as int?,
      newRecovered: json['NewRecovered'] as int?,
      totalRecovered: json['TotalRecovered'] as int?,
      date: json['Date'] as String?,
      premium: json['Premium'] == null
          ? null
          : PremiumVO.fromJson(json['Premium'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SummaryCountryVOToJson(SummaryCountryVO instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Country': instance.country,
      'CountryCode': instance.countryCode,
      'Slug': instance.slug,
      'NewConfirmed': instance.newConfirmed,
      'TotalConfirmed': instance.totalConfirmed,
      'NewDeaths': instance.newDeaths,
      'TotalDeaths': instance.totalDeaths,
      'NewRecovered': instance.newRecovered,
      'TotalRecovered': instance.totalRecovered,
      'Date': instance.date,
      'Premium': instance.premium,
    };
