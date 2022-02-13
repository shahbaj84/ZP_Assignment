import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zp_assignment/provider/country_provider.dart';
import 'package:zp_assignment/ui/country_list.dart';
import 'package:zp_assignment/utils/client_provider.dart';

import 'common/app_strings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      uri: graphqlEndpoint,
      child: MultiProvider(
      providers: [
        ChangeNotifierProvider<CountryProviders>(create: (context) => CountryProviders()),
      ],
      child:MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: 'Raleway'
        ),
        home:  const CountryList(),
      )),
    );
  }
}