import 'package:collection/collection.dart';
import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/global_vo.dart';
import '../../data/vos/summary_country_vo.dart';

part 'summary_response.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SUMMARY_RESPONSE,adapterName: "SummaryResponseAdapter")
class SummaryResponse {

  @JsonKey(name: "ID")
  @HiveField(0)
  String? id;

  @JsonKey(name: "Message")
  @HiveField(1)
  String? message;

  @JsonKey(name: "Global")
  @HiveField(2)
  GlobalVO? global;

  @JsonKey(name: "Countries")
  @HiveField(3)
  List<SummaryCountryVO>? countries;

  @JsonKey(name: "Date")
  @HiveField(4)
  String? date;

  SummaryResponse.empty();

  SummaryResponse({
    this.id,
    this.message,
    required this.global,
    this.countries,
    this.date,
  });

    factory SummaryResponse.fromJson(Map<String,dynamic> json) => _$SummaryResponseFromJson(json);

    Map<String,dynamic> toJson() => _$SummaryResponseToJson(this);

  @override
  String toString() {
    return 'SummaryResponse(id: $id, message: $message, global: $global, countries: $countries, date: $date)';
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is SummaryResponse &&
      other.id == id &&
      other.message == message &&
      other.global == global &&
      listEquals(other.countries, countries) &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      message.hashCode ^
      global.hashCode ^
      countries.hashCode ^
      date.hashCode;
  }
}
