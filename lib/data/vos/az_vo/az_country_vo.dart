import 'package:azlistview/azlistview.dart';
import 'package:covid_track/data/vos/summary_country_vo.dart';
import 'package:covid_track/persistance/daos/summary_country_dao.dart';

class AZCountryVO extends ISuspensionBean{

  final SummaryCountryVO? summaryCountry;
  final String tag;

  AZCountryVO({
    this.summaryCountry,
    required this.tag,
  });
  
  @override
  String getSuspensionTag() {
    return tag;
  }

}
