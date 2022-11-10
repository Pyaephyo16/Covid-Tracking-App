import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_COUNTRY_VO,adapterName: "CountryVOAdapter")
class CountryVO {

  @JsonKey(name: "Country")
  @HiveField(0)
  String? country;

  @JsonKey(name: "Slug")
  @HiveField(1)
  String? slug;

  @JsonKey(name: "ISO2")
  @HiveField(2)
  String? iso2;
  
  CountryVO({
    this.country,
    this.slug,
    this.iso2,
  });

  factory CountryVO.fromJson(Map<String,dynamic> json) => _$CountryVOFromJson(json);

  Map<String,dynamic> toJson() => _$CountryVOToJson(this);


  @override
  String toString() => 'CountryVO(country: $country, slug: $slug, iso2: $iso2)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CountryVO &&
      other.country == country &&
      other.slug == slug &&
      other.iso2 == iso2;
  }

  @override
  int get hashCode => country.hashCode ^ slug.hashCode ^ iso2.hashCode;
}
