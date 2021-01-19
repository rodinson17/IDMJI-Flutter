import 'package:flutter/material.dart';
import 'package:idmji/src/pages/coro_pagerview_page.dart';
import 'package:idmji/src/pages/himno_pagerview_page.dart';
import 'package:idmji/src/pages/home_page.dart';
import 'package:idmji/src/pages/himnos_page.dart';
import 'package:idmji/src/pages/coros_page.dart';
import 'package:idmji/src/pages/himno_detail_page.dart';
import 'package:idmji/src/pages/coro_detail_page.dart';
import 'package:idmji/src/pages/nested_scroll.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Himnos y Coros IDMJI', 
      theme: ThemeData( primaryColor: Colors.blue[900] ),
      initialRoute: 'home',
      routes: {
        'home': ( BuildContext context ) => HomePage(),
        'himnos': ( BuildContext context ) => HimnosPage(),
        'HimnoDetail': ( BuildContext context ) => HimnoDetailPage(),
        'coros': ( BuildContext context ) => CorosPage(),
        'CoroDetail': ( BuildContext context ) => CoroDetailPage(),
        'prueba': ( BuildContext context ) => NestedPage(),
        'CorosPagerView': ( BuildContext context ) => CoroPagerView(),
        'HimnosPagerView': ( BuildContext context ) => HimnoPagerView(),
      },
    ); 
  }

}
