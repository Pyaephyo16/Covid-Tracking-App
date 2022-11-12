import 'package:covid_track/bloc/search_bloc.dart';
import 'package:covid_track/data/vos/by_country_all_status_vo/by_country_all_status_vo.dart';
import 'package:covid_track/pages/country_page.dart';
import 'package:covid_track/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:covid_track/extension/push_extension.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon:const Icon(Icons.arrow_back_ios_rounded,size: 20,color: Colors.black,),
          ),
          title: const TitleTextView(text: "Covid Tracking By Country", color: Colors.black),
        ),
        body: Column(
          children: [
               Container(
      padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
       decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:const BorderRadius.only(
    bottomLeft: Radius.circular(32),
    bottomRight: Radius.circular(32),
        ),
        boxShadow: [
    BoxShadow(
      color: Colors.orange.withOpacity(0.2),
      blurRadius: 0.8,
      offset: Offset(0,10),
    ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
             Selector<SearchBloc,TextEditingController>(
                selector: (context,bloc) => bloc.searchText,
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,searchText,child) =>
                  SearchSection(
                      searchText: searchText,
                      tapForCountry: (){
                          context.push(CountryPage()).then((value){
                              SearchBloc bloc = Provider.of(context,listen: false);
                              if(value != null){
                                print("country name check ==> ${value}");
                                bloc.searchResult(value);
                              }
                          });
                      },
                   ),
                    ),
                Selector<SearchBloc,String?>(
                selector: (context,bloc) => bloc.confirmDate,
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,confirmDate,child) =>
                   SelectDateButonView(
                    confrimDate: confirmDate,
                    select: (){
                      print("select tap");
                    showDateRangePicker(
                      context: context,
                       firstDate: DateTime(2020),
                        lastDate: DateTime.now()).then((value){
                          SearchBloc bloc = Provider.of(context,listen: false);
                          if(value != null){
                            bloc.selectDateResult(value.start.toString(),value.end.toString());
                          }
                        });
                  }),
                ),    
               Selector<SearchBloc,TextEditingController>(
                selector: (context,bloc) => bloc.searchText,
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,searchText,child) =>
                 Selector<SearchBloc,String?>(
                selector: (context,bloc) => bloc.startDate,
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,startDate,child) =>
                     Selector<SearchBloc,String?>(
                selector: (context,bloc) => bloc.endDate,
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,endDate,child) =>
                    SearchButtonView(
                        search: (){
                          if(searchText.text.isEmpty){
                            snackBarNoti(context,"Please choose country");
                          }else if(startDate == null || endDate==null){
                            snackBarNoti(context,"Please choose date");
                          }else{
                            SearchBloc bloc = Provider.of(context,listen: false);
                            bloc.countryDataWithDateRange(searchText.text, startDate, endDate).then((value){
                            //Fluttertoast.showToast(msg: "Finished Search");
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                  ],
                 ),
               ),
            Expanded(
              child: Selector<SearchBloc,List<ByCountryAllStatusVO>?>(
                selector: (context,bloc) => bloc.byCountryAllStatusList,
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,byCountryAllStatusList,child) =>
              (byCountryAllStatusList == null) ?
               EmptyViewForCountryResult() :
                ListView.builder(
                  itemCount: byCountryAllStatusList.length,
                  itemBuilder: (BuildContext context,int index){
                    return CountryDataWithDateRangeResult(
                      byCountryAllStatus: byCountryAllStatusList[index],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

class CountryDataWithDateRangeResult extends StatelessWidget {
  const CountryDataWithDateRangeResult({
    Key? key,
    required this.byCountryAllStatus,
  }) : super(key: key);

  final ByCountryAllStatusVO byCountryAllStatus;

  @override
  Widget build(BuildContext context) {

     var numberFormat=NumberFormat(",###");

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 22,vertical: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
            CountryDataTextView(
              text: "${byCountryAllStatus.country}",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              ),
            SizedBox(height: 4,),
            CountryDataTextView(
              text: DateFormat("MMMM dd,yyyy (EEEE)").format(DateTime.parse(byCountryAllStatus.date ?? DateTime.now().toString())),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      countryData(
                        numberFormat: numberFormat,
                         byCountryAllStatus: byCountryAllStatus,
                         number: numberFormat.format(byCountryAllStatus.confirmed),
                         title: "Confirmed",
                         color: Colors.blue,
                         ),
                       countryData(
                        numberFormat: numberFormat,
                         byCountryAllStatus: byCountryAllStatus,
                         number: numberFormat.format(byCountryAllStatus.active),
                         title: "Active",
                         color: Colors.amber,
                         ), 
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      countryData(
                        numberFormat: numberFormat,
                         byCountryAllStatus: byCountryAllStatus,
                         number: numberFormat.format(byCountryAllStatus.confirmed),
                         title: "Confirmed",
                         color: Colors.green,
                         ),
                       countryData(
                        numberFormat: numberFormat,
                         byCountryAllStatus: byCountryAllStatus,
                         number: numberFormat.format(byCountryAllStatus.active),
                         title: "Active",
                         color: Colors.red,
                         ), 
                    ],
                  ),
                ),
              ],
            ),
          ), 
        ],
      ),
    );
  }
}

class countryData extends StatelessWidget {
  const countryData({
    Key? key,
    required this.numberFormat,
    required this.byCountryAllStatus,
    required this.number,
    required this.title,
    required this.color,
  }) : super(key: key);

  final NumberFormat numberFormat;
  final ByCountryAllStatusVO byCountryAllStatus;
  final String number;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
       decoration: BoxDecoration(
         color: color,
       ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
        CountryDataTextView(
          text: title,
          color: Colors.black,
          fontSize: 18,
          ),
          CountryDataTextView(
          text: number,
          color: Colors.black,
          fontSize: 14,
          ),
        ],
       ),
      ),);
  }
}

class CountryDataTextView extends StatelessWidget {
  const CountryDataTextView({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14,
    this.color = Colors.orange,
  }) : super(key: key);

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    );
  }
}

class EmptyViewForCountryResult extends StatelessWidget {
  const EmptyViewForCountryResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            clipBehavior: Clip.antiAlias,
            decoration:const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Image.asset("./asset/image/empty_doc.png",
              fit: BoxFit.cover,),
          ),
          Text("You can search data with city and date",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          )
        ],
      ),
    );
  }
}

class SelectDateButonView extends StatelessWidget {
  const SelectDateButonView({
    Key? key,
    required this.select,
    required this.confrimDate,
  }) : super(key: key);

  final Function select;
  final String? confrimDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        select();
      },
      child: Container(
       width: MediaQuery.of(context).size.width,
       height: 44,
       decoration: BoxDecoration(
         color: Colors.transparent,
         border: Border.all(color: Colors.orange,width: 2),
         borderRadius: BorderRadius.circular(8),
       ),
       alignment: Alignment.center,
       child: Text( (confrimDate == null) ? "Select Date" : confrimDate ?? "Something went wrong",
       style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
       ),
       ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
    required this.search,
  }) : super(key: key);

  final Function search;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        search();
      },
      child: Container(
       width: MediaQuery.of(context).size.width,
       height: 44,
       decoration: BoxDecoration(
         color: Colors.orange,
         borderRadius: BorderRadius.circular(8),
       ),
       alignment: Alignment.center,
       child: Text("Search",
       style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
       ),
       ),
      ),
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({
    Key? key,
    required this.searchText,
    required this.tapForCountry,
  }) : super(key: key);

  final TextEditingController searchText;
  final Function tapForCountry;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
              onTap: (){
                tapForCountry();
              },
              child: TextFormField(
                controller: searchText,
                enabled: false,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search,color: Colors.orange,size: 18,),
                  labelText: "Search City",
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.orange,
                  )
                ),
              ),
    );
  }
}