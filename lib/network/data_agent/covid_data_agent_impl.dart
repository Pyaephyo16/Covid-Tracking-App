import 'package:covid_track/data/vos/country_vo/country_vo.dart';
import 'package:covid_track/data/vos/by_country_all_status_vo/by_country_all_status_vo.dart';
import 'package:covid_track/network/api_constants.dart';
import 'package:covid_track/network/covid_api.dart';
import 'package:covid_track/network/data_agent/covid_data_agent.dart';
import 'package:covid_track/network/response/summary_response.dart';
import 'package:dio/dio.dart';

class CovidDataAgentImpl extends CovidDataAgent{

  late CovidApi covidApi;

  static final CovidDataAgentImpl _singleton = CovidDataAgentImpl._internal();

  factory CovidDataAgentImpl(){
    return _singleton;
  }

  CovidDataAgentImpl._internal(){
    final dio = Dio();

    dio.options = BaseOptions(
      headers: {
        HEADER_ACCEPT: APPLICATION_JSON,
        HEADER_CONTENT_TYPE: APPLICATION_JSON,
      }
    );
      covidApi = CovidApi(dio);
  }

  @override
  Future<SummaryResponse?> getSummaryData() {
    return covidApi.getSummary();
  }

  @override
  Future<List<ByCountryAllStatusVO>> getAllStatusByCountry(String country, String startDate, String endDate) {
    return covidApi.getAllStatusByCountry(country, startDate, endDate);
  }

  @override
  Future<List<CountryVO>> getCountry() {
    return covidApi.getCountry();
  }


}