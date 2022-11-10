import 'package:json_annotation/json_annotation.dart';

part 'by_country_all_status_vo.g.dart';

@JsonSerializable()
class ByCountryAllStatusVO {

  @JsonKey(name: "ID")
  String? id;

  @JsonKey(name: "Country")
  String? country;

  @JsonKey(name: "CountryCode")
  String? countryCode;

  @JsonKey(name: "Province")
  String? province;

  @JsonKey(name: "City")
  String? city;

  @JsonKey(name: "CityCode")
  String? cityCode;

  @JsonKey(name: "Lat")
  String? lat;

  @JsonKey(name: "Lon")
  String? lon;

  @JsonKey(name: "Confirmed")
  int? confirmed;

  @JsonKey(name: "Deaths")
  int? deaths;

  @JsonKey(name: "Recovered")
  int? recovered;

  @JsonKey(name: "Active")
  int? active;

  @JsonKey(name: "Date")
  String? date;
  ByCountryAllStatusVO({
    this.id,
    this.country,
    this.countryCode,
    this.province,
    this.city,
    this.cityCode,
    this.lat,
    this.lon,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.date,
  });

  factory ByCountryAllStatusVO.fromJson(Map<String,dynamic> json) => _$ByCountryAllStatusVOFromJson(json);

  Map<String,dynamic> toJson() => _$ByCountryAllStatusVOToJson(this);


  @override
  String toString() {
    return 'ByCountryAllStatusVO(id: $id, country: $country, countryCode: $countryCode, province: $province, city: $city, cityCode: $cityCode, lat: $lat, lon: $lon, confirmed: $confirmed, deaths: $deaths, recovered: $recovered, active: $active, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ByCountryAllStatusVO &&
      other.id == id &&
      other.country == country &&
      other.countryCode == countryCode &&
      other.province == province &&
      other.city == city &&
      other.cityCode == cityCode &&
      other.lat == lat &&
      other.lon == lon &&
      other.confirmed == confirmed &&
      other.deaths == deaths &&
      other.recovered == recovered &&
      other.active == active &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      country.hashCode ^
      countryCode.hashCode ^
      province.hashCode ^
      city.hashCode ^
      cityCode.hashCode ^
      lat.hashCode ^
      lon.hashCode ^
      confirmed.hashCode ^
      deaths.hashCode ^
      recovered.hashCode ^
      active.hashCode ^
      date.hashCode;
  }
}
