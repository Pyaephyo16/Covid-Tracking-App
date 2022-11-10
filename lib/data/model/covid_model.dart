import 'package:covid_track/data/vos/by_country_all_status_vo/by_country_all_status_vo.dart';
import 'package:covid_track/data/vos/country_vo/country_vo.dart';

import '../../network/response/summary_response.dart';

abstract class CovidModel{

void getSummaryData();
Future<List<CountryVO>> getCountry();
Future<List<ByCountryAllStatusVO>> getAllStatusByCountry(String country,String startDate,String endDate);

///Database
Stream<List<SummaryResponse>?> getSummaryDataListFromDatabase();
Stream<List<CountryVO>?> getAllCountriesFromDatabase();
}