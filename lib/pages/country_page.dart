import 'package:covid_track/bloc/country_bloc.dart';
import 'package:covid_track/data/vos/country_vo/country_vo.dart';
import 'package:covid_track/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatelessWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CountryBloc(),
      child: Scaffold(
         appBar: AppBar(
            backgroundColor: Colors.orange,
            leading: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon:const Icon(Icons.arrow_back_ios_rounded,size: 20,color: Colors.black,),
            ),
            title: const TitleTextView(text: "Select Country", color: Colors.black),
          ),
          body: Column(
            children: [
               Selector<CountryBloc,TextEditingController>(
                selector: (context,bloc) => bloc.countrySearch,
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,countrySearch,child) =>
                 SearchCountryTextFieldView(
                  countrySearch: countrySearch,
                  onChanged: (text){
                    CountryBloc bloc = Provider.of(context,listen: false);
                    bloc.changeSearch(text);
                  },
                  clear: (){
                    CountryBloc bloc = Provider.of(context,listen: false);
                    bloc.clearSearch();
                  },
                 ),
              ),
             const SizedBox(height: 22,),
             Expanded(
              child: Selector<CountryBloc,List<CountryVO>?>(
                selector: (context,bloc) => bloc.filterList,
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,filterList,child) =>
                Selector<CountryBloc,List<CountryVO>>(
                selector: (context,bloc) => bloc.countryList ?? [],
                shouldRebuild: (pre,next) => pre != next,
                builder: (context,countryList,child) =>
                  ListView.builder(
                    padding:const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filterList == null ? countryList.length : filterList.length,
                    itemBuilder: (BuildContext context,int index){
                      return CountryView(
                        filterList: filterList,
                        countryList: countryList,
                        index: index,
                       selectedCountry: (country){
                        Navigator.pop(context,country);
                       }, 
                      );
                    },
                  ),
                ),
              ),
             )
            ],
          ),
      ),
    );
  }
}

class CountryView extends StatelessWidget {
  const CountryView({
    Key? key,
    required this.filterList,
    required this.countryList,
    required this.index,
    required this.selectedCountry,
  }) : super(key: key);

  final List<CountryVO>? filterList;
  final List<CountryVO> countryList;
  final int index;
  final Function(String) selectedCountry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        selectedCountry("${ (filterList == null) ? countryList[index].slug : filterList?[index].slug}");
      },
      child: Card(
        elevation: 12,
        shadowColor: Colors.orange,
        child: ListTile(
          leading:const Icon(Icons.flag,color: Colors.orange,size: 18,),
          title: Text("${ (filterList == null) ? countryList[index].country : filterList?[index].country}"),
          subtitle: Text("${ (filterList == null) ? countryList[index].slug : filterList?[index].slug}"),
        ),
      ),
    );
  }
}

class SearchCountryTextFieldView extends StatelessWidget {
  const SearchCountryTextFieldView({
    Key? key,
    required this.countrySearch,
    required this.clear,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController countrySearch;
  final Function clear;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
      height: MediaQuery.of(context).size.height * 0.1,
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
      child: TextFormField(
        controller: countrySearch,
        onChanged: (text){
          onChanged(text);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.flag_sharp,color: Colors.orange,size: 16,),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear,color: Colors.orange,size: 16,),
            onPressed: (){
              clear();
            },
          ),
          contentPadding:const EdgeInsets.only(left: 0),
          labelText: "Type a country name",
          labelStyle:const TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.w400,
             color: Colors.orange,
          )
        ),
      ),
    );
  }
}