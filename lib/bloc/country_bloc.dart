import 'package:covid_track/data/model/covid_model_impl.dart';
import 'package:covid_track/data/vos/country_vo/country_vo.dart';
import 'package:flutter/cupertino.dart';

class CountryBloc extends ChangeNotifier{

  ///Model
CovidModelImpl covidModel = CovidModelImpl();

  ///State variable
  List<CountryVO>? countryList;
  List<CountryVO>? filterList;
  TextEditingController countrySearch = TextEditingController();
  bool isDispose = false;


  CountryBloc(){

    // //Get CountryList
    // covidModel.getCountry().then((value){
    //     countryList = value;  
    //     print("filter list lenght => ${countryList?.length} ${countryList?.first.country}");
    //     notifySafely();
    // }).catchError((error){
    //   print("country list bloc error ${error.toString()}");
    // });

        //Get CountryList from database
    covidModel.getAllCountriesFromDatabase().listen((value){
        countryList = value;  
        print("filter list lenght => ${countryList?.length} ${countryList?.first.country}");
        notifySafely();
    }).onError((error){
      print("country list bloc error ${error.toString()}");
    });

  }

  void clearSearch(){
    countrySearch.clear();
    filterList = null;
    notifySafely();
  }

  void changeSearch(String text){
    filterList = countryList?.where((CountryVO element) => element.country?.toLowerCase().contains(text.toLowerCase()) ?? false).toList();
      print("filter length ==> ${filterList?.length}");
    notifySafely();
  }

  notifySafely(){
    if(isDispose != true){
      notifyListeners();
    }
  }

  @override
  void dispose() {
    countrySearch.dispose();
    super.dispose();
    isDispose = true;
  }



}