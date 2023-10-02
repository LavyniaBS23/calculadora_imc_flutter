import 'package:calculadora_imc/pages/main_page.dart';
import 'package:calculadora_imc/pages/main_sqlite_page.dart';
import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //textTheme: GoogleFonts.robotoTextTheme()
      ),
      home: const MainSQLitePage(),
    );
  }
}