import 'package:covid_track/network/response/summary_response.dart';
import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:hive/hive.dart';

class SummaryResponseDao{

  static final SummaryResponseDao _singleton = SummaryResponseDao._internal();

  factory SummaryResponseDao(){
    return _singleton;
  }

  SummaryResponseDao._internal();

  void saveAllSummaryResponse(SummaryResponse summary)async{
    print("Save to db ${summary.id ?? "0"}");
     await summaryResponseBox().put(summary.id ?? "0",summary);
  }


  List<SummaryResponse>? getSummaryResponseList(){
    return summaryResponseBox().values.toList();
  }

  ///Reactive Programming
  
  Stream<void> summaryResponseEventStream(){
    return summaryResponseBox().watch();
  }


    List<SummaryResponse>? getAllSummaryResponseListData(){
    if(getSummaryResponseList() != null && (getSummaryResponseList()?.isNotEmpty ?? false)){
      return getSummaryResponseList();
    }else{
      return [];
    }
  }

    Stream<List<SummaryResponse>?> summaryResponseStreamList(){
    return Stream.value(getSummaryResponseList());
  }



  Box<SummaryResponse> summaryResponseBox(){
    return Hive.box<SummaryResponse>(BOX_NAME_SUMMARY_RESPONSE);
  }

}