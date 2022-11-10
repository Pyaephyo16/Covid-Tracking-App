import 'package:covid_track/data/vos/by_country_all_status_vo/by_country_all_status_vo.dart';
import 'package:covid_track/network/response/summary_response.dart';

import '../../data/vos/country_vo/country_vo.dart';

abstract class CovidDataAgent{

  Future<SummaryResponse?> getSummaryData();
  Future<List<CountryVO>> getCountry();
  Future<List<ByCountryAllStatusVO>> getAllStatusByCountry(String country,String startDate,String endDate);

}