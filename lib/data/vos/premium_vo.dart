import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'premium_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PREMIUM_VO,adapterName: "PremiumVOAdapter")
class PremiumVO {

@JsonKey(name: "premium")
@HiveField(0)
String? name;

  PremiumVO({
    this.name,
  });

    factory PremiumVO.fromJson(Map<String,dynamic> json) => _$PremiumVOFromJson(json);

  Map<String,dynamic> toJson() => _$PremiumVOToJson(this);

}
