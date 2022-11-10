import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_track/bloc/summary_bloc.dart';
import 'package:covid_track/data/vos/az_vo/az_country_vo.dart';
import 'package:covid_track/data/vos/summary_country_vo.dart';
import 'package:covid_track/network/response/summary_response.dart';
import 'package:covid_track/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:covid_track/extension/push_extension.dart';

const Duration kAnimationDurationForTitle = Duration(milliseconds: 3000);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> stringList = ["Total Confirmed","Total Death","Total Recovered","New Confirmed","New Death","New Recovered",];   
    List<String> list = ["Total Confirmed","Total Death","Total Recovered"];

    return ChangeNotifierProvider(
      create: (context) => SummaryBloc(),
      child: Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
          child: Container(
              decoration:const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const SizedBox(height: 100,),
               const TitleTextView(
                text: "Covid Tracking List",
                isUnderLine: true,
                color: Colors.black,
                ),
               const SizedBox(height: 60,),
                Column(
                  children: stringList.map((value){
                    return ListTile(
                      leading:const Icon(Icons.circle,color: Colors.black,size: 16,),
                      title: Text("${value}",
                      style:const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
       appBar: AppBar(
        backgroundColor: Colors.orange,
        title: TweenAnimationBuilder(
          duration: kAnimationDurationForTitle,
          tween: Tween<double>(begin: 0,end: 1),
          child:const TitleTextView(
            text: "Covid Tracking List",
            isUnderLine: false,
            color: Colors.black,
            ),
          builder: (context, value, child) => Opacity(
            opacity: value,
            child: Padding(
              padding: EdgeInsets.only(top: value*4),
              child: child),
          ),
        ),
        actions: [
          Theme(
            data: ThemeData(
              iconTheme: IconThemeData(
                color: Colors.black,
              )
            ),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: PopUpIconAndTextView(
                    text: "Search",
                    icon:const Icon(Icons.search,size: 22,color: Colors.orange,),
                    popUpTouch: (){
                      context.push(SearchPage());
                    },
                  ),
                ),
                 PopupMenuItem(
                  child: PopUpIconAndTextView(
                    text: "Exit",
                    icon:const Icon(Icons.exit_to_app_rounded,size: 22,color: Colors.orange,),
                    popUpTouch: (){
                      exit(0);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
       ),
        body: RefreshIndicator(
          onRefresh: ()async{
            SummaryBloc bloc = Provider.of(context,listen: false);
            bloc.getSummaryData();
          },
          child: Column(
            children: [
              Selector<SummaryBloc,SummaryResponse>(
                selector: (context,bloc) => bloc.summary ?? SummaryResponse.empty(),
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,summary,child) =>
                 Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.white,
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      updateDateView(
                        summary: summary,
                      ),
                     const SizedBox(height: 8,),
              Expanded(
             child: LatestCardScrollList(list: list,summary: summary,stringList: stringList,),
                      ),
                    ],
                   ),
                 ),
                ),
               const SizedBox(height: 26,),
                Selector<SummaryBloc,SummaryResponse>(
                  selector: (context,bloc) => bloc.summary ?? SummaryResponse.empty(),
                  shouldRebuild: (pre,next) => pre != next,
                  builder: (context,summary,child) =>
                 Selector<SummaryBloc,List<AZCountryVO>>(
                  selector: (context,bloc) => bloc.azList ?? [],
                  shouldRebuild: (pre,next) => pre != next,
                  builder: (context,azList,child) =>
                     Expanded(
                       child: SummaryByCountriesView(
                        summary: summary,
                        azList: azList,
                                       ),
                     ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryByCountriesView extends StatelessWidget {
  const SummaryByCountriesView({
    Key? key,
    required this.summary,
    required this.azList,
  }) : super(key: key);

  final SummaryResponse summary;
  final List<AZCountryVO> azList;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.2),
            blurRadius: 0.8,
            offset: Offset(0,-10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           TweenAnimationBuilder(
            duration: kAnimationDurationForTitle,
            tween: Tween<double>(begin: 0,end: 1),
             child: const TitleTextView(
              text: "Countries",
              color: Colors.orange,
              ),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Padding(
                  padding: EdgeInsets.only(top: value * 6),
                  child: child,
                ),
              ),
           ),
           Expanded(
             child: AzListView(
                    data: azList,
                   indexBarMargin:const EdgeInsets.only(right: 6), 
                    itemCount: azList.length,
                    itemBuilder: (BuildContext context,int index){
              final tag = azList[index].getSuspensionTag();    
                  final offStage = !azList[index].isShowSuspension; 
                return  TweenAnimationBuilder(
                  duration: kAnimationDurationForTitle,
                  tween: Tween<double>(begin: 0,end: 1),
                  child:  SummaryByCountryDataView(
                      summaryCountry: summary.countries?[index] ?? SummaryCountryVO.empty(),
                      index: index,
                      tag: "",
                      offStage: false,
                    ),
                  builder: (context, value, child) => Padding(
                    padding: EdgeInsets.only(top: value * 24,right: 20),
                    child: Opacity(
                      opacity: value,
                      child: child),
                  ),
                );
              }
                     ),
           ),
        ],
      ),
    );
  }
}

class SummaryByCountryDataView extends StatelessWidget {
   SummaryByCountryDataView({
    Key? key,
    required this.summaryCountry,
    required this.index,
    required this.tag,
    required this.offStage,
  }) : super(key: key);

  final SummaryCountryVO summaryCountry;
  final int index;
    final String tag;
  final bool offStage;

 var numberFormat=NumberFormat(",###");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      width: MediaQuery.of(context).size.width,
      height: 186,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 2,color: Colors.orange),
        // border: Border.symmetric(
        //   horizontal: BorderSide(color: Colors.orange,width: 2),
        //   vertical:  BorderSide(color: Colors.orange,width: 14),
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          NameAndNewConfirmedByCountry(summaryCountry: summaryCountry),
          Divider(color: Colors.orange,thickness:1),
          Expanded(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                totalAllDataViewBySummaryCountry(
                  summaryCountry: summaryCountry,
                  title: "Total \nConfirmed",
                  number: numberFormat.format(summaryCountry.totalConfirmed),
                  color: Colors.blue,
                  ),
                  totalAllDataViewBySummaryCountry(
                  summaryCountry: summaryCountry,
                  title: "Total \nDeath",
                  number: numberFormat.format(summaryCountry.totalDeaths),
                  color: Colors.red,
                  ),
                  totalAllDataViewBySummaryCountry(
                  summaryCountry: summaryCountry,
                  title: "Total \nRecovered",
                  number: numberFormat.format(summaryCountry.totalRecovered),
                  color: Colors.green,
                  ),
              ],
            ),
          ),
          Divider(color: Colors.orange,thickness:1),
          Text(DateFormat("MMMM dd,yyyy (EEEE)").format(DateTime.parse(summaryCountry.date ?? DateTime.now().toString())),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          ),
        ],
      ),
    );
  }
}

class totalAllDataViewBySummaryCountry extends StatelessWidget {
   totalAllDataViewBySummaryCountry({
    Key? key,
    required this.summaryCountry,
    required this.title,
    required this.number,
    required this.color,
  }) : super(key: key);

  final SummaryCountryVO summaryCountry;
  final String title;
  final String number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),
        ),
        SizedBox(height: 8,),
        Text(number,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        ),
      ],
    );
  }
}

class NameAndNewConfirmedByCountry extends StatelessWidget {
  const NameAndNewConfirmedByCountry({
    Key? key,
    required this.summaryCountry,
  }) : super(key: key);

  final SummaryCountryVO summaryCountry;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: SummaryCountryNameView(summaryCountry: summaryCountry))),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 100,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 2,color: Colors.orange),
            ),
                    child: Text("New : ${summaryCountry.newConfirmed}",
                    style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
                    ),
                    ),    
          ),
        ),
      ],
    );
  }
}

class SummaryCountryNameView extends StatelessWidget {
  const SummaryCountryNameView({
    Key? key,
    required this.summaryCountry,
  }) : super(key: key);

  final SummaryCountryVO summaryCountry;

  @override
  Widget build(BuildContext context) {
    return Text("${summaryCountry.country}",
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    );
  }
}

class LatestCardScrollList extends StatelessWidget {
  const LatestCardScrollList({
    Key? key,
    required this.list,
    required this.summary,
    required this.stringList,
  }) : super(key: key);

  final List<String> list;
  final SummaryResponse summary;
  final List<String> stringList;

  @override
  Widget build(BuildContext context) {
    return Container(
       child: CarouselSlider.builder(
    itemCount: list.length,
         options: CarouselOptions(
       onPageChanged: (index,_){
            print("Key =======================> card$index");
           },
          height: 240,
         aspectRatio: 16/9,
         viewportFraction: 0.8,
         enableInfiniteScroll: false,
        reverse: false,
        enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          ),
        itemBuilder: (context,int index,int pageViewIndex){
         return TweenAnimationBuilder(
          duration: kAnimationDurationForTitle,
          tween: Tween<double>(begin: 0,end: 1),
           child: LatestDataCardVew(
             summary: summary,
             index: index,
             list: stringList,
           ),
           builder: (context, value, child) => Opacity(
            opacity: value,
            child: child,
           ),
         );
        },
       ),
     );
  }
}

class updateDateView extends StatelessWidget {
  const updateDateView({
    Key? key,
    required this.summary,
  }) : super(key: key);

  final SummaryResponse summary;

  @override
  Widget build(BuildContext context) {

    return TweenAnimationBuilder(
      duration: kAnimationDurationForTitle,
      tween: Tween<double>(begin: 0,end: 1),
      builder: (context, value, child) => Padding(
        padding: EdgeInsets.only(left: value * 16,top: 10),
        child: child,
      ),
      child: RichText(
        text: TextSpan(
          text: "Update Date :  ",
          style:const TextStyle(
            fontSize: 15,
            color: Colors.orange,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            TextSpan(
              text: DateFormat("MMMM dd,yyyy (EEEE)").format(DateTime.parse(summary.global?.date ?? DateTime.now().toString())),
              style:const TextStyle(
            fontSize: 18,
            color: Colors.orange,
            fontWeight: FontWeight.w600,
          ),
            ),
          ]
        ),
      ),
    );
  }
}

class LatestDataCardVew extends StatelessWidget {
   LatestDataCardVew({
    Key? key,
    required this.summary,
    required this.index,
    required this.list,
  }) : super(key: key);

  final SummaryResponse summary;
  final int index;
  final List<String> list;

 var numberFormat=NumberFormat(",###");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(12),
       gradient: LinearGradient( 
        colors: (index == 0) ?
         [
     const Color.fromRGBO(26, 82, 118,1.00),
       const Color.fromRGBO(41, 128, 185,1.00),
        const Color.fromRGBO(214, 234, 248,1.00),
        ] 
        : (index == 1) ?
         [
        const Color.fromRGBO(148, 49, 38,1.00),
       const Color.fromRGBO(231, 76, 60,1.00),
     const Color.fromRGBO(245, 183, 177,1.00),
         ] 
         :
          [
     const Color.fromRGBO(24, 106, 59,1.00),
       const Color.fromRGBO(88, 214, 141,1.00),
        const Color.fromRGBO(171, 235, 198,1.00),
          ],
        
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
       ),
      ),
     child: LatestDataView(
      summary: summary,
      totalTitle: list[index],
      newTitle: list[index+3],
      totalNum: (index == 0) ? 
      numberFormat.format(summary.global?.totalConfirmed ?? 0) :
      (index == 1) ? 
      numberFormat.format(summary.global?.totalDeaths ?? 0)
      : numberFormat.format(summary.global?.totalRecovered ?? 0),
      newNum: (index == 0) ? 
      numberFormat.format(summary.global?.newConfirmed ?? 0) :
      (index == 1) ? 
      numberFormat.format(summary.global?.newDeaths ?? 0)
      : numberFormat.format(summary.global?.newRecovered ?? 0),
      color: (index ==0 ) ?
       Color.fromRGBO(26, 82, 118, 1.00) :
        (index == 1) ? 
        Color.fromRGBO(146, 43, 33, 1.00) :
        Color.fromRGBO(25, 111, 61, 1.00),
      ), 
    );
  }
}

class LatestDataView extends StatelessWidget {
   LatestDataView({
    Key? key,
    required this.summary,
    required this.newNum,
    required this.totalNum,
    required this.totalTitle,
    required this.newTitle,
    required this.color,
  }) : super(key: key);

  final SummaryResponse summary;
  final String totalTitle;
  final String newTitle;
  final String totalNum;
  final String newNum;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     crossAxisAlignment: CrossAxisAlignment.start,
     mainAxisSize: MainAxisSize.min,
     children: [
       Text(totalTitle,
       style: TextStyle(
         color: Colors.orange[200],
         fontSize: 18,
         fontWeight: FontWeight.w600,
       ),
       ),
       Padding(
         padding: EdgeInsets.only(left: 120,top: 8),
         child: Text(totalNum,
         style: TextStyle(
           color: Colors.orange[200],
           fontSize: 16,
           fontWeight: FontWeight.w400,
         ),
         ),
       ),
       Container(width: MediaQuery.of(context).size.width,
         height: 2,
         color: color,
         ),
        Text(newTitle,
       style: TextStyle(
         color: Colors.orange[200],
         fontSize: 18,
         fontWeight: FontWeight.w600,
       ),
       ),
       Padding(
         padding: EdgeInsets.only(left: 120,top: 8),
         child: Text(newNum,
         style: TextStyle(
           color: Colors.orange[200],
           fontWeight: FontWeight.w400,
         ),
         ),
       ), 
     ],
    );
  }
}

class PopUpIconAndTextView extends StatelessWidget {
  const PopUpIconAndTextView({
    Key? key,
    required this.icon,
    required this.text,
    required this.popUpTouch,
  }) : super(key: key);

  final Widget icon;
  final String? text;
  final Function popUpTouch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        popUpTouch();
      },
      child: Row(
        children: [
          icon,
         const SizedBox(width: 12,),
          Text(text ?? "",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),)
        ],
      ),
    );
  }
}

class TitleTextView extends StatelessWidget {
  const TitleTextView({
    Key? key,
   required this.text,
   this.isUnderLine = false,
   required this.color,
  }) : super(key: key);

  final String? text;
  final bool isUnderLine;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text ?? "",
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color,
      decoration: (isUnderLine) ? TextDecoration.underline : null,
    ),
    );
  }
}