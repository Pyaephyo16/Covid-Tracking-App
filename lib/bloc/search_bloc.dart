import 'package:covid_track/data/model/covid_model_impl.dart';
import 'package:covid_track/data/vos/by_country_all_status_vo/by_country_all_status_vo.dart';
import 'package:covid_track/data/vos/country_vo/country_vo.dart';
import 'package:covid_track/network/data_agent/covid_data_agent_impl.dart';
import 'package:flutter/cupertino.dart';

class SearchBloc extends ChangeNotifier{

  ///Model
  CovidModelImpl covidModel = CovidModelImpl();

  ///State variable
  bool isDispose = false;
  TextEditingController searchText = TextEditingController();
  List<ByCountryAllStatusVO>? byCountryAllStatusList;
  String? startDate;
  String? endDate;
  String? confirmDate;


    Future<String> countryDataWithDateRange(String country,String startDate,String endDate){
      print("call function ${country} ${startDate} ${endDate}");
     return covidModel.getAllStatusByCountry(country, startDate, endDate).then((value){
      byCountryAllStatusList = value;
      print("by country all status list length -> ${byCountryAllStatusList?.length}");
      notifySafely();
        return Future.value("Search Finished");
      }).catchError((error){
        print("get all country status bloc error ${error.toString()}");
      });
    }

    void searchResult(String countryName){
          searchText.text = countryName;
          notifySafely();
    }

    void selectDateResult(String start,String end){
      startDate = start;
      endDate = end;
      String confirmStart = start.split(" ")[0];
      String confirmEnd = end.split(" ")[0];
      confirmDate = "$confirmStart - $confirmEnd";
      notifySafely();
    }

  notifySafely(){
    if(isDispose != true){
      notifyListeners();
    }
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
    isDispose = true;
  }

}