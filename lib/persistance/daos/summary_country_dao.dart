import 'package:covid_track/data/vos/summary_country_vo.dart';
import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:hive/hive.dart';

class SummaryCountryDao{
  
  static final SummaryCountryDao _singleton = SummaryCountryDao._internal();

  factory SummaryCountryDao(){
    return _singleton;
  }

  SummaryCountryDao._internal();

  void saveAllSummaryCountry(List<SummaryCountryVO> summaryCountryList)async{
      Map<String,SummaryCountryVO> summaryMap = Map.fromIterable(
        summaryCountryList,
        key: (summary) => summary.id,
        value: (summary) => summary,
      );
      await summaryCountryBox().putAll(summaryMap);
  }

  List<SummaryCountryVO> getAllSummaryCountry(){
    return summaryCountryBox().values.toList();
  }

  Box<SummaryCountryVO> summaryCountryBox(){
    return Hive.box<SummaryCountryVO>(BOX_NAME_SUMMARY_COUNTRY_VO);
  }

}