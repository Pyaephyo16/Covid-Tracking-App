import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_GLOBAL_VO,adapterName: "GlobalVOAdapter")
class GlobalVO {

  @JsonKey(name: "NewConfirmed")
  @HiveField(0)
  int? newConfirmed;

  @JsonKey(name: "TotalConfirmed")
  @HiveField(1)
  int? totalConfirmed;

  @JsonKey(name: "NewDeaths")
  @HiveField(2)
  int? newDeaths;

  @JsonKey(name: "TotalDeaths")
  @HiveField(3)
  int? totalDeaths;

  @JsonKey(name: "NewRecovered")
  @HiveField(4)
  int? newRecovered;

  @JsonKey(name: "TotalRecovered")
  @HiveField(5)
  int? totalRecovered; 

  @JsonKey(name: "Date")
  @HiveField(6)
  String? date;
  
  GlobalVO({
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
  });

  factory GlobalVO.fromJson(Map<String,dynamic> json) => _$GlobalVOFromJson(json);

  Map<String,dynamic> toJson() => _$GlobalVOToJson(this);

  @override
  String toString() {
    return 'GlobalVO(newConfirmed: $newConfirmed, totalConfirmed: $totalConfirmed, newDeaths: $newDeaths, totalDeaths: $totalDeaths, newRecovered: $newRecovered, totalRecovered: $totalRecovered, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GlobalVO &&
      other.newConfirmed == newConfirmed &&
      other.totalConfirmed == totalConfirmed &&
      other.newDeaths == newDeaths &&
      other.totalDeaths == totalDeaths &&
      other.newRecovered == newRecovered &&
      other.totalRecovered == totalRecovered &&
      other.date == date;
  }

  @override
  int get hashCode {
    return newConfirmed.hashCode ^
      totalConfirmed.hashCode ^
      newDeaths.hashCode ^
      totalDeaths.hashCode ^
      newRecovered.hashCode ^
      totalRecovered.hashCode ^
      date.hashCode;
  }
}
