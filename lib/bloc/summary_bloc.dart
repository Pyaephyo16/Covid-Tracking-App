import 'package:azlistview/azlistview.dart';
import 'package:covid_track/data/model/covid_model.dart';
import 'package:covid_track/data/model/covid_model_impl.dart';
import 'package:covid_track/data/vos/az_vo/az_country_vo.dart';
import 'package:covid_track/network/response/summary_response.dart';
import 'package:flutter/cupertino.dart';

class SummaryBloc extends ChangeNotifier{

///Model
CovidModelImpl covidModel = CovidModelImpl();

///State variable
SummaryResponse? summary;
List<AZCountryVO>? azList;
bool isDispose = false;

SummaryBloc(){

 ///Get summary Database
 getSummaryData();
//  covidModel.getSummaryDataListFromDatabase().listen((value){
//       print("summary data bloc => ${value?.last.global?.date.toString()}");
//         summary = value?.last;
//   azList = summary?.countries?.map((data) => AZCountryVO(summaryCountry: data, tag: data.country?[0].toUpperCase() ?? "")).toList();
//      SuspensionUtil.sortListBySuspensionTag(azList);
//         notifySafely();
//     }).onError((error){
//       print("summary data error bloc => ${error.toString()}");
//     });

}

 ///Get summary 
 void getSummaryData(){
  //  covidModel.getSummaryData().then((value){
//       print("summary data bloc => ${value?.global?.date.toString()}");
//         summary = value;
//         notifySafely();
//     }).catchError((error){
//       print("summary data error bloc => ${error.toString()}");
//     }); 
 covidModel.getSummaryDataListFromDatabase().listen((value){
      print("summary data bloc => ${value?.last.global?.date.toString()}");
        summary = value?.last;
  azList = summary?.countries?.map((data) => AZCountryVO(summaryCountry: data, tag: data.country?[0].toUpperCase() ?? "")).toList();

     SuspensionUtil.sortListBySuspensionTag(azList);
        notifySafely();
    }).onError((error){
      print("summary data error bloc => ${error.toString()}");
    });
 }


  notifySafely(){
    if(isDispose!= true){
      notifyListeners();
    }
  }

@override
  void dispose() {
    super.dispose();
    isDispose = true;
  }



}