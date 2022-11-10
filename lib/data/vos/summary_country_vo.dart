import 'package:covid_track/data/vos/premium_vo.dart';
import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_country_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SUMMARY_COUNTRY_VO,adapterName: "SummaryCountryVOAdapter")
class SummaryCountryVO {

  @JsonKey(name: "ID")
  @HiveField(0)
  String? id;

  @JsonKey(name: "Country")
  @HiveField(1)  
  String? country;

  @JsonKey(name: "CountryCode")
  @HiveField(2)  
  String? countryCode;

  @JsonKey(name: "Slug")
  @HiveField(3)  
  String? slug;

  @JsonKey(name: "NewConfirmed")  
  @HiveField(4)
  int? newConfirmed;

  @JsonKey(name: "TotalConfirmed")
  @HiveField(5)  
  int? totalConfirmed;

  @JsonKey(name: "NewDeaths")
  @HiveField(6)  
  int? newDeaths;

  @JsonKey(name: "TotalDeaths")
  @HiveField(7)  
  int? totalDeaths;

  @JsonKey(name: "NewRecovered")
  @HiveField(8)  
  int? newRecovered;

  @JsonKey(name: "TotalRecovered")
  @HiveField(9)  
  int? totalRecovered; 

  @JsonKey(name: "Date")
  @HiveField(10)    
  String? date;

  @JsonKey(name: "Premium")
  @HiveField(11)  
  PremiumVO? premium;
  
  SummaryCountryVO.empty();

  SummaryCountryVO({
    this.id,
    this.country,
    this.countryCode,
    this.slug,
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
    this.premium,
  });

  
  factory SummaryCountryVO.fromJson(Map<String,dynamic> json) => _$SummaryCountryVOFromJson(json);

  Map<String,dynamic> toJson() => _$SummaryCountryVOToJson(this);


  @override
  String toString() {
    return 'SummaryCountryVO(id: $id, country: $country, countryCode: $countryCode, slug: $slug, newConfirmed: $newConfirmed, totalConfirmed: $totalConfirmed, newDeaths: $newDeaths, totalDeaths: $totalDeaths, newRecovered: $newRecovered, totalRecovered: $totalRecovered, date: $date, premium: $premium)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SummaryCountryVO &&
      other.id == id &&
      other.country == country &&
      other.countryCode == countryCode &&
      other.slug == slug &&
      other.newConfirmed == newConfirmed &&
      other.totalConfirmed == totalConfirmed &&
      other.newDeaths == newDeaths &&
      other.totalDeaths == totalDeaths &&
      other.newRecovered == newRecovered &&
      other.totalRecovered == totalRecovered &&
      other.date == date &&
      other.premium == premium;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      country.hashCode ^
      countryCode.hashCode ^
      slug.hashCode ^
      newConfirmed.hashCode ^
      totalConfirmed.hashCode ^
      newDeaths.hashCode ^
      totalDeaths.hashCode ^
      newRecovered.hashCode ^
      totalRecovered.hashCode ^
      date.hashCode ^
      premium.hashCode;
  }
}
