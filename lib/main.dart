import 'package:covid_track/data/vos/country_vo/country_vo.dart';
import 'package:covid_track/data/vos/global_vo.dart';
import 'package:covid_track/data/vos/premium_vo.dart';
import 'package:covid_track/data/vos/summary_country_vo.dart';
import 'package:covid_track/network/response/summary_response.dart';
import 'package:covid_track/pages/country_page.dart';
import 'package:covid_track/pages/search_page.dart';
import 'package:covid_track/pages/splash_page.dart';
import 'package:covid_track/persistance/hive_constanats.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  await Hive.initFlutter();

  Hive.registerAdapter(GlobalVOAdapter());
  Hive.registerAdapter(SummaryCountryVOAdapter());
  Hive.registerAdapter(PremiumVOAdapter());
  Hive.registerAdapter(SummaryResponseAdapter());
  Hive.registerAdapter(CountryVOAdapter());

  await Hive.openBox<SummaryResponse>(BOX_NAME_SUMMARY_RESPONSE);
  await Hive.openBox<CountryVO>(BOX_NAME_COUNTRY_VO);

  runApp(
   const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColor: Colors.orange,
        iconTheme:const IconThemeData(
          color: Colors.black,
        )
      ),
      home:const SplashPage(),
    );
  }
}

