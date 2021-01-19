import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:idmji/src/models/coro_model.dart';
import 'package:idmji/src/models/himno_model.dart';

class DataProvider {
  List<Himno> listHimnos = List<Himno>();
  List<Coro> listCoros = List<Coro>();

  Future<List<Himno>> getHimnos() async {  
    if ( listHimnos.isEmpty ) {
      final resp = await rootBundle.loadString( 'data/himnos.json' );
      final dataMap = json.decode( resp );
      final himnos = Himnos.fromJsonList( dataMap['himnos'] );
      listHimnos = himnos.listHimnos;
    }
    
    return listHimnos;
  }

  Future<List<Himno>> getListFilterHimnos( String query ) async {
    if ( listHimnos.isEmpty || query.isEmpty ) return [];

    final listFilter = listHimnos.where( 
      ( item ) => item.title.toLowerCase().contains( query.toLowerCase() )
    ).toList();    
    return listFilter;
  }
  

  Future<List<Coro>> getCoros() async {    
    if ( listCoros.isEmpty ) {
      final resp = await rootBundle.loadString( 'data/coros.json' );
      final dataMap = json.decode( resp );
      final coros = Coros.fromJsonList( dataMap['coros'] );
      listCoros = coros.listCoros;
    }
    
    return listCoros;
  }

  Future<List<Coro>> getListFilterCoros( String query ) async {
    if ( listCoros.isEmpty || query.isEmpty ) return [];

    final listFilter = listCoros.where( 
      ( item ) => item.title.toLowerCase().contains( query.toLowerCase() )
    ).toList();    
    return listFilter;
  }

}

