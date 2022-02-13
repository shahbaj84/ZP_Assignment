import 'dart:async';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zp_assignment/models/country.dart';
import 'package:zp_assignment/provider/country_provider.dart';
import 'package:zp_assignment/widgets/country_item.dart';
import 'package:zp_assignment/widgets/loader.dart';

class CountryList extends StatefulWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountryListState();
  }
}

class _CountryListState extends State<CountryList> {
  Timer? debounce;
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => Provider.of<CountryProviders>(context, listen: false).fetchCountryList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    CountryProviders countryProviders = Provider.of<CountryProviders>(context, listen: false);
    return Consumer<CountryProviders>(
      builder: (BuildContext context, CountryProviders bloc,_) => Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: countryProviders.languages.isNotEmpty?Column(
          children: [
            const SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                child: ChipsChoice<Languages>.multiple(
                  value: countryProviders.getFilterlanguages,
                  onChanged: (val) => countryProviders.setFilterlanguages(val),
                  choiceItems: C2Choice.listFrom<Languages, Languages>(
                    source: countryProviders.languages,
                    value: (index, item) => item,
                    label: (index, item) => item.name!,
                  ),
                  wrapped: true,
                  textDirection: TextDirection.rtl,
                   choiceStyle: const C2ChoiceStyle(
                     borderColor: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.blueGrey,
                  ),
                  choiceActiveStyle: const C2ChoiceStyle(
                    brightness: Brightness.dark,
                    color: Colors.blueGrey,
                    borderShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: Colors.blueGrey)
                    ),
                  ),
                ),
              ),
            ),
            Align(alignment: Alignment.bottomRight,child: Padding(
              padding: const EdgeInsets.symmetric(vertical:15.0,horizontal: 20 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(child: const Text("Clear"),onPressed: (){
                    countryProviders.resetCountryList();
                    countryProviders.filterCountriesByLang();
                    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
                      Navigator.of(context).pop();
                    }
                  },style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red)),),
                  const SizedBox(width: 10,),
                  ElevatedButton(child: const Text("Apply"),onPressed: (){
                   if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
                      Navigator.of(context).pop();
                    }
                    countryProviders.setLoader(true);
                    if(countryProviders.filterlanguages.isNotEmpty) {
                      countryProviders.filterCountriesByLang();
                    }
                    countryProviders.setLoader(false);
                  },),
                ],
              ),
            ),)
          ],
        ):const Center(child: Text("No Language Found")),
      ),
      appBar: AppBar(title: countryProviders.isSearchEnabled?TextField(
            autofocus: true,
            onChanged:(text)=> _onSearchChanged(text,countryProviders),
            decoration: InputDecoration(
            hintText: 'Search by country code',
            hintStyle: const TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  width: 0, 
                  style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(10),
            fillColor: Colors.white70,
          ),
          style: const TextStyle( fontSize: 16.0),
        ):const Text("Countries",style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [GestureDetector(child: Icon(countryProviders.isSearchEnabled?Icons.close:Icons.search),onTap: (){
          countryProviders.setSearchEnabled();
      },),
      IconButton(icon: const Icon(Icons.g_translate_rounded),onPressed: (){
        _scaffoldKey.currentState?.openEndDrawer();
      },)],),
      body: countryProviders.isloading
        ? const Center(
            child: Loader(
              dotRadius: 5,
              radius: 20,
            ),
          )
        : ListView.builder(
            itemCount: countryProviders.getCountries.length,
            itemBuilder: (_, index) {
              return CountryItem(
                country: countryProviders.getCountries[index],
              );
            }
          )
      ));
  }
  _onSearchChanged(String query,CountryProviders countryProviders) {
    if(query.isEmpty){
      countryProviders.resetCountryList();
    }
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 3000), () {
      if(query.isNotEmpty){
        countryProviders.searchCountryByCountryCode(query,context);
      }
    });
  }
  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }
}
