import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:hive/hive.dart';

import '../../data/vos/global_vo.dart';

class GlobalDao{

  static final GlobalDao _singleton = GlobalDao._internal();

  factory GlobalDao(){
    return _singleton;
  }

  GlobalDao._internal();

  void saveAllGlobal(GlobalVO global)async{
    await globalBox().put(global.date,global);
  }

  GlobalVO? getAllGlobal(String date){
      return globalBox().get(date);
  }


  Box<GlobalVO> globalBox(){
    return Hive.box<GlobalVO>(BOX_NAME_GLOBAL_VO);
  }

}