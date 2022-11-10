import 'package:covid_track/data/model/covid_model.dart';
import 'package:covid_track/data/vos/country_vo/country_vo.dart';
import 'package:covid_track/data/vos/by_country_all_status_vo/by_country_all_status_vo.dart';
import 'package:covid_track/network/data_agent/covid_data_agent.dart';
import 'package:covid_track/network/data_agent/covid_data_agent_impl.dart';
import 'package:covid_track/network/response/summary_response.dart';
import 'package:covid_track/persistance/daos/country_dao.dart';
import 'package:covid_track/persistance/daos/summary_country_dao.dart';
import 'package:covid_track/persistance/daos/summary_response_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class CovidModelImpl extends CovidModel{

static final CovidModelImpl _singleton = CovidModelImpl._internal();

factory CovidModelImpl(){
  return _singleton;
}

  CovidModelImpl._internal();

  CovidDataAgent covidDataAgent = CovidDataAgentImpl();

  SummaryResponseDao summaryResponseDao = SummaryResponseDao();
  CountryDao countryDao = CountryDao();


  @override
  void getSummaryData(){
     covidDataAgent.getSummaryData().then((value){
      print("covid summary data model ${value?.global?.date ?? ""} ${value?.message}");
       summaryResponseDao.saveAllSummaryResponse(value!);
    }).catchError((error){
      print("covid summary data error model ${error.toString()}");
    });
  }

    @override
  Future<List<ByCountryAllStatusVO>> getAllStatusByCountry(String country,String startDate,String endDate) {
     print("by country all status model  ==> ${country} ${startDate}  end ${endDate}" );
 return covidDataAgent.getAllStatusByCountry(country, startDate, endDate).then((value){
  return value;
 }).catchError((error){
    print("by country all status model error ==> ${error.toString()}");
  });
  }

  @override
  Future<List<CountryVO>> getCountry() {
    return covidDataAgent.getCountry().then((value){
      print("country model ==> ${value.first.country}");
      countryDao.saveAllCountries(value);
      return value;
    }).catchError((error){
      print("country error model ${error.toString()}");
    });
  }
  
  ///Database
  
  @override
  Stream<List<SummaryResponse>?> getSummaryDataListFromDatabase(){
    this.getSummaryData();
   return summaryResponseDao
   .summaryResponseEventStream()
   .startWith(summaryResponseDao.summaryResponseStreamList())
   .map((event) => summaryResponseDao.getAllSummaryResponseListData());
  }
  
  @override
  Stream<List<CountryVO>?> getAllCountriesFromDatabase() {
    this.getCountry();
    return countryDao
    .getAllCountriesEventStream()
    .startWith(countryDao.getAllCountriesStream())
    .map((event) => countryDao.getAllCountriesData());
  }





}