import 'package:covid_track/data/vos/country_vo/country_vo.dart';
import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:hive/hive.dart';

class CountryDao{

  static final CountryDao _singleton = CountryDao._internal();

  factory CountryDao(){
    return _singleton;
  }

  CountryDao._internal();

  void saveAllCountries(List<CountryVO> countryList)async{
    Map<String,CountryVO> countryMap = Map.fromIterable(
      countryList,
      key: (country) => country.iso2,
      value: (country) => country,
    );
    await countryBox().putAll(countryMap);
  }

  List<CountryVO>? getAllCountries(){
    return countryBox().values.toList();
  }

  ///Reactive Programming
  Stream<void> getAllCountriesEventStream(){
    return countryBox().watch();
  }

  Stream<List<CountryVO>?> getAllCountriesStream(){
    return Stream.value(getAllCountries());
  }

  List<CountryVO>? getAllCountriesData(){
    if(getAllCountries() != null && (getAllCountries()?.isNotEmpty ?? false)){
      return getAllCountries();
    }else{
      return [];
    }
  }

  Box<CountryVO> countryBox(){
    return Hive.box<CountryVO>(BOX_NAME_COUNTRY_VO);
  }

}