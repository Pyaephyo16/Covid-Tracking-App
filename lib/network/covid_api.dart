import 'package:covid_track/network/api_constants.dart';
import 'package:covid_track/network/response/summary_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../data/vos/by_country_all_status_vo/by_country_all_status_vo.dart';
import '../data/vos/country_vo/country_vo.dart';

part 'covid_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class CovidApi{

  factory CovidApi(Dio dio) = _CovidApi;

  @GET(END_POINT_SUMMARY)
  Future<SummaryResponse> getSummary();


  @GET(END_POINT_COUNTRY)
  Future<List<CountryVO>> getCountry();

  @GET("$END_POINT_BY_COUNTRY_ALL_STATUS/{countryName}")
  Future<List<ByCountryAllStatusVO>> getAllStatusByCountry(
    @Path("countryName") String countryName,
    @Query("from") String startDate,
    @Query("to") String endDate,
  );

}