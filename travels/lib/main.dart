 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travels/presentation/pages/user_pages/search_page.dart';
import 'package:travels/presentation/providers/app_data_provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
    create:(context)=>AppDataProvider(),
    child: MyApp()));
 }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Travels Booking",
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.amber,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber
        )
      ),
      home: SearchPage(),
    );
  }
}